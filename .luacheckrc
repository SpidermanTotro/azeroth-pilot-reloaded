-- luacheck configuration tuned for WoW addon development
-- See: https://luacheck.readthedocs.io/

std = "lua51"

-- Files to include are determined by luacheck CLI; we add a relaxed globals list below
globals = {
  "APR", "TomTom", "LibStub", "HereBeDragons", "HBD",
  "CreateFrame", "UIParent", "GetItemInfo", "GetItemCount",
  "C_QuestLog", "C_SpellBook", "C_Map", "C_MapExplorationInfo",
  -- common WoW/C API helpers and Lua builtins we intentionally allow
  "tinsert", "tremove", "pairs", "ipairs", "type", "print",
}

-- Allow larger line lengths in some cases used by generated route tables
max_line_length = 200

-- Don't error for trailing whitespace in legacy files
ignore = {
  "trailing-space",
}
---@diagnostic disable: lowercase-global
std = "lua51"
max_line_length = false
exclude_files = {
    ".github/",
    ".vscode/",
    "**/libs/**/*.lua",
    ".luacheckrc",
    "**/locales/*.lua",
    "**/.luarocks/**/", -- Created by the GitHub Action
    "**/.install/**/",  -- Created by the GitHub Action
}
ignore = {
    "1..", -- Everything related to globals
    "211", -- Unused local variable
    "212", -- Unused argument
    "213", -- Unused loop variable
    "311", -- Reassigned variable
    -- "42.", -- Shadowing an upvalue argument (e.g. "self")
    "43.", -- Shadowing an upvalue
    "542", -- An empty if branch

}
