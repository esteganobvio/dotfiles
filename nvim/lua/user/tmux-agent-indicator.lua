local M = {}

local script = vim.fn.expand('~/.tmux/plugins/tmux-agent-indicator/scripts/agent-state.sh')

--- Notify tmux-agent-indicator of agent state (no-op outside tmux).
---@param agent string
---@param state 'running'|'needs-input'|'done'|'off'
function M.set_state(agent, state)
  if vim.env.TMUX == nil or vim.fn.filereadable(script) == 0 then
    return
  end
  vim.fn.jobstart({ 'bash', script, '--agent', agent, '--state', state }, { detach = true })
end

return M
