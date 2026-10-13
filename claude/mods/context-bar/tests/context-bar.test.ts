import { expect, test } from 'claude-code/testing'

const BAND = {
  plugin: 'context-bar',
  component: 'AbovePrompt',
  requestId: 'above-prompt',
  surface: 'terminal',
  viewport: { columns: 80, rows: 30 },
  props: { hasSurvey: false, isWorking: false, maxRows: 6, bodyColumns: 60, scroll: { offset: 0, bodyRows: 6 }, view: {} },
} as const

const BREAKDOWN = {
  categories: [
    { name: 'System prompt', tokens: 3000, color: 'promptBorder', isDeferred: false, kind: 'used' },
    { name: 'Messages', tokens: 43000, color: 'permission', isDeferred: false, kind: 'used' },
    { name: 'MCP tools', tokens: 900, color: 'suggestion', isDeferred: true, kind: 'deferred' },
    { name: 'Free space', tokens: 121000, color: 'inactive', isDeferred: false, kind: 'free' },
    { name: 'Autocompact buffer', tokens: 33000, color: 'inactive', isDeferred: false, kind: 'buffer' },
  ],
  totalTokens: 46000,
  maxTokens: 200000,
  rawMaxTokens: 200000,
  percentage: 23,
}

function stubEngine(on, saved: Map<string, unknown>) {
  on('store.get', ($, e) => ({ value: saved.get(e.key) }))
  on('store.set', ($, e) => {
    saved.set(e.key, e.value)
    return { value: undefined }
  })
  on('session.usage', () => ({ value: { context: { tokens: 46000, window: 200000, percent: 23, breakdown: BREAKDOWN } } }))
  on('command.register', () => ({ value: undefined }))
  on('ui.toast', () => ({ value: undefined }))
  on('session.start', () => ({ cwd: '/work' }))
  on('ui.render', () => ({ type: 'Text', props: {}, children: ['drawn by Claude Code'] }))
}

test('draws the bar and legend above the prompt', async ($, on) => {
  stubEngine(on, new Map())
  await $.session.start({ surface: 'terminal', isInteractive: true, cwd: '/work' })

  const ui = await $.ui.mount(BAND)
  expect(await ui.find({ type: 'Text', text: ' 46k/200k 23%' })).toBeDefined()
  expect(await ui.find({ type: 'Text', text: 'System prompt 3.0k' })).toBeDefined()
  expect(await ui.find({ type: 'Text', text: 'Messages 43k' })).toBeDefined()
  // Deferred tool schemas sit outside the window
  expect(await ui.find({ type: 'Text', text: /MCP tools/ })).toBeUndefined()
  // Other mods' band content is kept
  expect(await ui.find({ type: 'Text', text: 'drawn by Claude Code' })).toBeDefined()
})

test('/context-bar hides the bar and remembers it', async ($, on) => {
  const saved = new Map<string, unknown>()
  stubEngine(on, saved)
  await $.session.start({ surface: 'terminal', isInteractive: true, cwd: '/work' })

  await $.command.run({ command: 'context-bar', args: '' })
  expect(saved.get('enabled')).toBe(false)

  const ui = await $.ui.mount(BAND)
  expect(await ui.find({ type: 'Text', text: ' 46k/200k 23%' })).toBeUndefined()
})
