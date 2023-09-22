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
  -- if not opts.default_text then
  --   if mode then
  --     opts.default_text = '"' .. M.escape_rg_text(M.get_text(mode)) .. '"'
  --   else
  --     opts.default_text = '"'
  --   end
  -- end
  if mode then
    opts.default_text = opts.default_text .. '"' .. M.escape_rg_text(M.get_text(mode)) .. '"'
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

M.RetNullIfInputPoint = function(string)
  return string == '.' and '' or string
end


M.ExtractFileInfo = function()
  local current_line = vim.api.nvim_get_current_line()
  local file_path, line_num, col_num = current_line:match('(%S+):(%d+):(%d+)')
  if not file_path and not line_num and not col_num then
    vim.api.nvim_err_writeln("[ERROR]: cannot find the correspond file and line")
    return
  end
  print(file_path, line_num, col_num)
  local file = io.open(file_path, "r")
  if not file then
    vim.api.nvim_err_writeln("[ERROR]:", file_path, "not exist")
    return
  end
  M.GoToFile(file_path, line_num, col_num)
end

M.GoToFile = function(file, line, col)
  local cur_buf = vim.api.nvim_get_current_buf()
  local cur_file_type = vim.api.nvim_buf_get_option(cur_buf, 'filetype')
  if (cur_file_type == "toggleterm") then
    vim.api.nvim_command(":ToggleTerm")
  end

  -- 获取所有的缓冲区列表
  local buffers = vim.api.nvim_list_bufs()
  -- 遍历每个缓冲区
  for _, buf in ipairs(buffers) do
    -- 切换到当前缓冲区
    -- vim.api.nvim_set_current_buf(buf)
    -- 获取缓冲区的属性
    local buf_name = vim.api.nvim_buf_get_name(buf)
    local buf_type = vim.api.nvim_buf_get_option(buf, 'buftype')
    local file_type = vim.api.nvim_buf_get_option(buf, 'filetype')
    local buf_modified = vim.api.nvim_buf_get_option(buf, 'modified')
    local buf_line_count = vim.api.nvim_buf_line_count(buf)

    -- if (buf_name == file) then
    --   vim.api.nvim_set_current_buf(buf)
    --   vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) })
    --   return
    -- end
    if (buf_type == "") then
      -- vim.api.nvim_set_current_buf(buf)
      vim.api.nvim_command('edit ' .. file)
      vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) })
      return
    end

    -- 打印缓冲区属性和文件名
    -- print(string.format("Buffer Name: %s", buf_name))
    -- print(string.format("buf Type: %s", buf_type))
    -- print(string.format("File Type: %s", file_type))
    -- print(string.format("Modified: %s", buf_modified))
    -- print(string.format("Line Count: %s", buf_line_count))
    -- print("-------------------------")
  end
  vim.api.nvim_command('edit ' .. file)
  vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) })
end


M.git_gitui_toggle = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local gitui = Terminal:new {
    cmd = "gitui",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
    },
    on_open = function(_)
      vim.cmd "startinsert!"
    end,
    on_close = function(_) end,
    count = 99,
  }
  gitui:toggle()
end

return M
