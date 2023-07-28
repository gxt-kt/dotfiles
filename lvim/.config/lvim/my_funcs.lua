-- my own useful functions

local M = {}

M.escape_rg_text = function(text)
  text = text:gsub('%(', '\\%(')
  text = text:gsub('%)', '\\%)')
  text = text:gsub('%[', '\\%[')
  text = text:gsub('%]', '\\%]')
  text = text:gsub('%{', '\\%{')
  text = text:gsub('%}', '\\%}')
  text = text:gsub('"', '\\"')
  text = text:gsub('-', '\\-')
  text = text:gsub('+', '\\-')

  return text
end

M.live_grep_raw = function(opts, mode)
  opts = opts or {}
  opts.prompt_title = 'Live Grep Raw (-t[ty] include, -T exclude -g"[!] [glob])"'
  if not opts.default_text then
    if mode then
      opts.default_text = '"' .. M.escape_rg_text(M.get_text(mode)) .. '"'
    else
      opts.default_text = '"'
    end
  end

  require('telescope').extensions.live_grep_args.live_grep_args(
  -- require('telescope.themes').get_ivy(opts)
  -- require('telescope.themes').get_cursor(opts)
    require('telescope.themes').get_dropdown(opts)
  )
end

M.get_text = function(mode)
  local current_line = vim.api.nvim_get_current_line()
  local start_pos = {}
  local end_pos = {}
  if mode == 'v' then
    start_pos = vim.api.nvim_buf_get_mark(0, "<")
    end_pos = vim.api.nvim_buf_get_mark(0, ">")
  elseif mode == 'n' then
    start_pos = vim.api.nvim_buf_get_mark(0, "[")
    end_pos = vim.api.nvim_buf_get_mark(0, "]")
  end

  return string.sub(current_line, start_pos[2] + 1, end_pos[2] + 1)
end


-- nvim0.9后废弃了range format，我们需要自己实现
-- Ref: https://www.reddit.com/r/neovim/comments/zv91wz/range_formatting/
-- nvim0.9 之前像这样使用 lvim.keys.visual_mode["<leader>lf"]   = "<ESC><cmd>lua vim.lsp.buf.range_formatting()<CR>" -- deprecated from 0.9
M.range_formatting = function()
  local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
  vim.lsp.buf.format({
    range = {
      ["start"] = { start_row, 0 },
      ["end"] = { end_row, 0 },
    },
    async = true,
  })
end


M.ExecuteAndPrintCmd = function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local selected_text = table.concat(lines, "\n")

  if selected_text ~= '' then
    -- local command_output = vim.fn.system(selected_text)

    local command = "zsh -i -c '" .. selected_text .. "'"
    print(command)
    local handle = io.popen(command)
    local command_output = handle:read("*a")
    handle:close()

    local contents = vim.split(command_output, "\n")

    -- 检查最后一个元素是否为空字符串，如果是则删除，否则会多打印一个空行
    if contents[#contents] == '' then
      table.remove(contents, #contents)
    end

    vim.fn.setpos('.', end_pos)

    vim.api.nvim_put({ "{>>>>>>>>>>>>>>>>>>>>>>>>>>" }, 'l', true, false)
    vim.fn.setreg('+', contents) -- 将输出内容放入寄存器 +
    -- vim.cmd('normal! "+p')
    table.insert(contents, "}<<<<<<<<<<<<<<<<<<<<<<<<<<")
    vim.api.nvim_put(contents, 'l', true, false)
    -- vim.api.nvim_put({"}<<<<<<<<<<<<<<<<<<<<<<<"}, 'l', true , false)
  else
    print("no text selected")
  end
end

return M
