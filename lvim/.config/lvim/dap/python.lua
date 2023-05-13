local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return '/usr/bin/python'
    end;
  },
}
dap.adapters.python = {
  type = "executable";
  -- command = '/usr/bin/python';
  command='/home/gxt_kt/.local/share/nvim/mason/bin/debugpy-adapter';
  -- args = { '-m', 'debugpy.adapter' };
  args = {};
}
