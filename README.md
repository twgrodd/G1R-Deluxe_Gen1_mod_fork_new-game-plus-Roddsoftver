# New Game Plus Roddsoft

A maintained fork of [New Game Plus](https://github.com/notquiteog/new_game_plus) for Gen1Recomp / G1R Deluxe. Credits to the original New Game Plus authors and the upstream Gen1Recomp project.

After defeating the Champion, activate NG+ from the Start Menu. It scales ordinary trainers and wild encounters, offers eight Gym Leader challenge teams and three sequential optional bosses, and supports repeatable difficulty cycles. The dedicated NG+ menu awards its own money and items for victories.

## External Gym victory compatibility API

Other mods can report a **confirmed victory** over one of the eight NG+ Gym Leaders without directly modifying NG+ save data:

```lua
local ngPlus = mod.find and mod.find("new-game-plus-roddsoft")
local exports = ngPlus and ngPlus.exports
if exports and type(exports.recordExternalVictory) == "function" then
  -- Only call from the battle completion callback after result == "win".
  local result = exports.recordExternalVictory(game, "misty")
  if not result.success then
    -- Optional: log result.reason; do not interrupt normal rematch cleanup.
  end
end
```

**Important:** The fork's manifest ID is `new-game-plus-roddsoft`, **not** the upstream `new_game_plus`. Existing Trainer Rematch RoddSoft integration currently searches for the upstream ID and must be updated separately. This fork does not modify Trainer Rematch RoddSoft.

Accepted challenge IDs: `brock`, `misty`, `surge`, `erika`, `koga`, `sabrina`, `blaine`, `giovanni`. Optional bosses and arbitrary IDs cannot be completed externally.

The API returns a table with `success`, `challengeId`, `firstWin`, `alreadyCompleted`, and `allGymsComplete` on success. Failure returns `{ success = false, reason = "inactive" | "invalid_challenge" | "invalid_game" }`.

External wins are **progress-only**: they update the same saved completion flags, menu DONE labels, gym count and boss unlocks as menu wins. They do **not** grant NG+ money, items, or victory dialogue. Completing a challenge externally forfeits its first-win NG+ menu reward for that cycle; subsequent menu wins use the normal repeat-win reward. Calling the API again for the same challenge is idempotent. Progress is reset normally on starting the next cycle.

The caller must verify that the battle used the NG+ Gym roster and that the player actually won; the API cannot independently authenticate another mod's battle. A missing NG+ mod or missing API must not prevent rematch cleanup.

## Testing

Run `lua tests/external_victory.lua` from the repository root for lightweight compatibility checks. Full in-game regression testing of menu battles, rematches, persistence across reloads and cycle advancement is still recommended.

## Releases

GitHub Actions packages an installable ZIP with `manifest.json` at the archive root and a `sha256sums.txt` checksum file.
