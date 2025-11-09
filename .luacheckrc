-- luacheck configuration: ignore optional globals used at runtime by WoW addons or optional libs
-- Using lua51 standard for WoW compatibility

std = lua51

-- globals expected at runtime (TomTom, LibStub, HereBeDragons-2.0)
global = {
  TomTom = true,
  LibStub = true,
  HereBeDragons = true,
  APR = true,
}

