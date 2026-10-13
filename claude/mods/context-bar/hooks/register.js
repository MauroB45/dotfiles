// The last /context breakdown, or null before the first measurement
let breakdown = null

// Whether the bar shows. Saved in $.store so the choice outlasts the session.
let enabled = true

// The bar's character for each kind of row. Deferred tool schemas sit outside
// the window, so they are left out of the bar.
const BLOCKS = { used: '█', buffer: '▒', free: '░' }

// 1234 -> 1.2k, 200000 -> 200k
function formatTokens(tokens) {
  if (tokens < 1000) return String(tokens)
  const k = tokens / 1000
  return (k < 10 ? k.toFixed(1) : Math.round(k)) + 'k'
}

// Share `columns` between the rows by their tokens, so the widths add up to
// exactly `columns`. Every used row with tokens gets at least one cell.
function widthsOf(rows, columns) {
  const total = rows.reduce((sum, row) => sum + row.tokens, 0) || 1
  const exact = rows.map((row) => (row.tokens / total) * columns)
  const widths = exact.map(Math.floor)

  let left = columns - widths.reduce((sum, w) => sum + w, 0)
  const byRemainder = exact
    .map((value, i) => ({ i, remainder: value - Math.floor(value) }))
    .sort((a, b) => b.remainder - a.remainder)
  for (const { i } of byRemainder) {
    if (left === 0) break
    widths[i] += 1
    left -= 1
  }

  rows.forEach((row, i) => {
    if (row.kind !== 'used' || row.tokens === 0 || widths[i] > 0) return
    const widest = widths.indexOf(Math.max(...widths))
    if (widths[widest] > 1) {
      widths[widest] -= 1
      widths[i] = 1
    }
  })

  return widths
}

// Pack legend entries into lines no wider than `columns`
function linesOf(entries, columns) {
  const lines = [[]]
  let width = 0
  for (const entry of entries) {
    const length = entry.label.length + 2
    if (width > 0 && width + length + 2 > columns) {
      lines.push([])
      width = 0
    }
    lines[lines.length - 1].push(entry)
    width += length + (width > 0 ? 2 : 0)
  }
  return lines
}

// Measure the context window by category, as /context does. `summary`
// estimates locally, so it costs no API call.
async function refresh($) {
  try {
    const usage = await $.session.usage({ breakdown: 'summary', columns: 80 })
    breakdown = usage.context.breakdown ?? null
  } catch {
    breakdown = null
  }
  $.ui.invalidate('ui.render')
}

export function register(on) {
  on('session.start', async ($, e, next) => {
    const saved = await $.store.get('enabled')
    if (typeof saved === 'boolean') enabled = saved
    if (enabled) await refresh($)

    await $.command.register({
      name: 'context-bar',
      description: 'Toggle the context bar above the prompt',
      immediate: true,
    })
    return next(e)
  })

  // After each turn, and when the usage figures move
  on('session.measure', async ($, e, next) => {
    if (enabled) await refresh($)
    return next(e)
  })

  // /clear, /resume, /branch and compaction change what the window holds
  on('classic.SessionStart', { source: ['clear', 'resume', 'fork', 'compact'] }, async ($, e, next) => {
    if (enabled) await refresh($)
    return next(e)
  }).catch(($, e, next) => next(e))

  on('command.run', { command: 'context-bar' }, async ($) => {
    enabled = !enabled
    await $.store.set('enabled', enabled)
    if (enabled) await refresh($)
    $.ui.invalidate('ui.render')
    $.ui.toast(enabled ? 'Context bar on' : 'Context bar off')
    return {}
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    if (!enabled || !breakdown) return next(e)

    const { Box, Text } = $.ui.resolve(e)
    const columns = e.props.bodyColumns ?? e.viewport?.columns ?? 80

    const rows = breakdown.categories.filter((row) => row.kind !== 'deferred' && row.tokens > 0)
    const percent =
      ' ' + formatTokens(breakdown.totalTokens) + '/' + formatTokens(breakdown.maxTokens) + ' ' + breakdown.percentage + '%'
    const widths = widthsOf(rows, Math.max(columns - percent.length, 10))

    const bar = Box({
      flexDirection: 'row',
      children: [
        ...rows.map((row, i) =>
          Text({ color: row.color, children: [BLOCKS[row.kind].repeat(widths[i])] }),
        ),
        Text({ dimColor: true, children: [percent] }),
      ],
    })

    const entries = rows.map((row) => ({ row, label: row.name + ' ' + formatTokens(row.tokens) }))
    const legend = linesOf(entries, columns).map((line) =>
      Box({
        flexDirection: 'row',
        columnGap: 2,
        children: line.map(({ row, label }) =>
          Box({
            flexDirection: 'row',
            children: [
              Text({ color: row.color, children: [BLOCKS[row.kind] + ' '] }),
              Text({ dimColor: true, children: [label] }),
            ],
          }),
        ),
      }),
    )

    // Keep whatever the mods after this one draw in the band
    const theirs = await next(e)
    return Box({
      flexDirection: 'column',
      children: theirs ? [bar, ...legend, theirs] : [bar, ...legend],
    })
  })
}
