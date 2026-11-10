local M = {}
local pins = {}

function M.clear_pins()
  pins = nil
end

function M.get_pins()
  return pins
end

function M.find_buf(buf)
  for k, v in pairs(pins) do
    if v.nr == buf then
      return k
    end
  end
  return nil
end

function M.pin(...)
  local buf, pinnr, _ = ...
  buf = buf or vim.fn.bufnr()
  if not vim.fn.bufexists(buf) then
    return
  end

  if pinnr == nil then
    local prompt = "== Pinned buffers: ==\n\n"
    for k, v in pairs(pins) do
      prompt = string.format("%s %d - %s\n", prompt, k, v.path)
    end
    prompt = prompt .. "==\nEnter pinnr to pin buffer to: "

    pinnr = tonumber(vim.fn.input(prompt))
    if pinnr == nil then
      return
    end
  end

  local path = vim.fn.bufname(buf)
  pins[pinnr] = {
    nr = buf,
    path = path,
  }
  vim.print(string.format("Pinned buffer #%d (%s)", buf, path))
end

function M.unpin_buf(...)
  local buf, _ = ...
  buf = buf or vim.fn.bufnr()
  if not vim.fn.bufexists(buf) then
    return
  end

  local pinnr = M.find_buf(buf)
  if pinnr == nil then
    return
  end

  local path = pins[pinnr].path
  pins[pinnr] = nil
  vim.print(string.format("Uninned buffer #%d (%s)", buf, path))
end

function M.unpin_nr(pinnr)
  if pins[pinnr] == nil then
    return
  end

  local path = pins[pinnr].path
  pins[pinnr] = nil
  vim.print(string.format("Uninned pin #%d (%s)", pinnr, path))
end

function M.nav_to_pin(pinnr)
  if pins[pinnr] == nil then
    return
  end

  vim.cmd("buffer " .. pins[pinnr].nr)
end

function M.setup()
  vim.api.nvim_create_autocmd('BufDelete', {
    callback = function(event)
      local buf = event.buf

      local pinnr = M.find_buf(buf)
      while pinnr ~= nil do
        pins[pinnr] = nil
        pinnr = M.find_buf(buf)
      end
    end,
  })
end

return M
