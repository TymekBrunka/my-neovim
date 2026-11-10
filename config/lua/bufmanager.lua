local M = {}

function M.get_file_buffers()
  local bufs = vim.api.nvim_list_bufs()
  local buffers = {}
  for _, v in ipairs(bufs) do
    local buftype = vim.api.nvim_buf_get_option(v, "buftype")

    if vim.api.nvim_buf_is_valid(v) and vim.bo[v].buflisted
        and buftype ~= "nofile" and buftype ~= "prompt" then
      table.insert(buffers, {
        nr = v,
        name = vim.fn.bufname(v)
      })
    end
  end

  return buffers
end

local win = nil
local win_buf = nil

function M.update_win_buf(bufs)
  local lines = {}

  for _, v in ipairs(bufs) do
    table.insert(lines, string.format("%d - %s", v.nr, v.name));
  end

  vim.bo[win_buf].modifiable = true
  vim.api.nvim_buf_set_text(win_buf, 0, 0, -1, -1, { "" })
  vim.api.nvim_buf_set_lines(win_buf, 0, #bufs, false, lines)
  vim.bo[win_buf].modifiable = false
end

-- Helper function to calculate sizes based on current screen dimensions
function M.get_float_bounds()
  local screen_width = vim.o.columns
  local screen_height = vim.o.lines

  return {
    width = math.floor(screen_width * 0.8),
    height = math.floor(screen_height * 0.8),
    col = math.floor(screen_width * 0.1),
    row = math.floor(screen_height * 0.1),
  }
end

function M.toggle_centered_float()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
    win = nil
    return
  end

  local bounds = M.get_float_bounds()

  if not win_buf or not vim.api.nvim_buf_is_valid(win_buf) then
    win_buf = vim.api.nvim_create_buf(false, true)
  end

  local opts = {
    relative = "editor",
    width = bounds.width,
    height = bounds.height,
    col = bounds.col,
    row = bounds.row,
    style = "minimal",
    border = "rounded",
  }

  local bufs = M.get_file_buffers()
  M.update_win_buf(bufs)

  vim.keymap.set('', 'dd', function()
    local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
    -- local bufs = M.get_file_buffers()
    vim.bo[bufs[r].nr].buflisted = false
    vim.api.nvim_buf_delete(bufs[r].nr, { unload = true })
    table.remove(bufs, r)
    M.update_win_buf(bufs)
  end, { buf = win_buf })

  vim.keymap.set('', '<Enter>', function()
    local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
    -- local bufs = M.get_file_buffers()
    if win ~= nil then
      vim.api.nvim_win_close(win, false)
    end
    vim.cmd("buffer " .. bufs[r].nr)
  end, { buf = win_buf })

  vim.keymap.set('', 'a', function()
    if win ~= nil then
      vim.api.nvim_win_close(win, false)
    end
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(":e ", true, false, true),
      "n",
      false
    )
  end, { buf = win_buf })

  win = vim.api.nvim_open_win(win_buf, true, opts)
end

local float_resize_group = vim.api.nvim_create_augroup("FloatWindowResize", { clear = false })

vim.api.nvim_create_autocmd("VimResized", {
  group = float_resize_group,
  callback = function()
    if win and vim.api.nvim_win_is_valid(win) then
      vim.schedule(function()
        if not (win and vim.api.nvim_win_is_valid(win)) then return end
        local bounds = M.get_float_bounds()
        vim.api.nvim_win_set_config(win, {
          relative = "editor", -- Keep it anchored to the full editor grid
          width = bounds.width,
          height = bounds.height,
          col = bounds.col,
          row = bounds.row,
        })
      end)
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufDelete' }, {
  group = float_resize_group,
  callback = function(event)
    if event.buf ~= win_buf then
      return
    end

    if win_buf ~= nil then
      if vim.api.nvim_buf_is_valid(win_buf) then
        vim.api.nvim_buf_delete(win_buf, {})
      end
    end

    if win ~= nil then
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end
  end
})

return M
