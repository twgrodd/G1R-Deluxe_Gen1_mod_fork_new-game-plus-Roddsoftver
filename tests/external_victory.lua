-- Run from repository root: lua tests/external_victory.lua
-- Self-contained regression checks for the public compatibility contract.
local function makeMod()
  local state = {}
  local hooks = {}
  local mod = {
    save = {
      get = function(_, key) return state[key] end,
      set = function(_, key, value) state[key] = value end,
    },
    content = { screens = { register = function() end } },
    events = { on = function() end },
    hooks = { wrap = function(_, key, fn) hooks[key] = fn end },
    exports = {},
    log = { info = function() end },
  }
  assert(loadfile("main.lua"))(mod)
  return mod, state, hooks
end

local mod, state, hooks = makeMod()
local writes, money = 0, 10000
local game = { save = { money = money, party = {} }, writeSave = function() writes = writes + 1 end }
local api = mod.exports.recordExternalVictory
assert(type(api) == "function")
assert(api(game, "misty").reason == "inactive")
state.active = true
assert(api(game, "not_a_gym").reason == "invalid_challenge")
assert(api(game, "blue_prime").reason == "invalid_challenge")
assert(api(game, "misty").firstWin == true)
assert(state.wins.misty == true and writes == 1)
assert(api(game, "misty").alreadyCompleted == true and writes == 1)
assert(game.save.money == money, "external win must not grant money")
assert(not mod.exports.isActive() == false)
local count = 0
for _, gym in ipairs(mod.exports.gyms) do
  count = count + 1
  assert(api(game, gym.id).success)
end
assert(count == 8)
assert(api(game, "misty").allGymsComplete)
assert(state.wins.blue_prime == nil)
assert(writes == 8, "one write per first win")
local savedWins = state.wins
assert(savedWins.misty and savedWins.giovanni, "progress must persist in mod save")
-- The menu's challenge unlock logic reads the same wins table; advancing a
-- cycle clears wins, so a new first victory must be counted again.
state.cycle = 2
state.wins = {}
assert(api(game, "misty").firstWin)
assert(writes == 9)
assert(game.save.money == money)
assert(type(hooks["trainer.party"]) == "function")
assert(type(hooks["encounter.species"]) == "function")
print("external victory compatibility tests passed")
