plugin_dir = config_dir .. "/plugins"
if vim.fn.isdirectory(plugin_dir) then
  vim.fn.mkdir(plugin_dir, 'p')
end

LOADED_PLUGINS = {}

local function install(plugin)
  local repo = ""
  local cmd = { "git", "clone", "--depth=1", "https://github.com/" }

  -- get repo
  if type(plugin) == "string" then
    repo = plugin
  else
    repo = plugin[1]
  end
  -- construct path to clone repo
  local name = string.sub(repo, repo:find('/') + 1)
  local path = vim.fn.expand(plugin_dir .. '/' .. name)

  -- dont clone when we have the folder
  if vim.fn.isdirectory(path) then
    cmd[4] = cmd[4] .. repo
    table.insert(cmd, path)

    -- additional options (preinstall)
    if type(plugin) == "table" then
      -- dependencies
      if plugin.dependencies ~= nil then
        for _, d in ipairs(plugin.dependencies) do
          install(d)
        end
      end
      -- branch + tag
      local branch = nil
      if plugin.branch ~= nil then
        branch = plugin.branch
      end
      -- cloning with tag shares the same logic as branches but here they have bigger priority
      if plugin.tag ~= nil then
        if tag ~= "*" then
          branch = plugin.branch
        end
      end

      if branch ~= nil then
        table.insert(cmd, "--branch=" .. branch)
      end
    end
    vim.fn.system(cmd)
  end

  if LOADED_PLUGINS[name] == nil then
    vim.opt.rtp:prepend(path)
    LOADED_PLUGINS[name] = true
  end

  -- additional options (postinstall)
  if type(plugin) == "table" then
    if plugin.config ~= nil then
      plugin.config()
    end
  end
end

local function install_many(plugs)
  for _, p in ipairs(plugs) do
    install(p)
  end
end

plug = {
  install = install,
  install_many = install_many
}
