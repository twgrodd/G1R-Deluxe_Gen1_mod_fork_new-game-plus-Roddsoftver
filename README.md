# New Game Plus Roddsoft

A maintained fork of [New Game Plus](https://github.com/notquiteog/new_game_plus) for Gen1Recomp / G1R Deluxe. Credits to the original New Game Plus authors and the upstream Gen1Recomp project.

After defeating the Champion, activate NG+ from the Start Menu. It scales ordinary trainers and wild encounters, offers eight Gym Leader challenge teams and three sequential optional bosses, and supports repeatable difficulty cycles. The dedicated NG+ menu awards its own money and items for victories.

## Blue Prime overworld encounter (v1.0.6 test)

**Blue Prime** is now added as a stationary NPC on **ROUTE_22, X=19, Y=4** (walk-grid coordinates). This is separate from the two original rival encounters. Talk to him after activating NG+ and completing all eight NG+ Gym challenges to start his existing Blue Prime boss battle. Before unlocking him, he gives locked dialogue. The NG+ menu battle remains available; both routes share the same boss victory state and rewards.

This is an **in-game test build**: map placement, sprite choice, collision, interaction, and battle completion have not yet been verified in a running game. Please report whether the NPC appears, whether talking to him works, and whether winning marks Blue Prime DONE in the NG+ menu. Dragon Master and Red Echo overworld NPCs are **not yet implemented**.

## Overworld coordinate finder (v1.0.5)

The NG+ menu includes **SHOW COORDINATES** after activation. Stand on the intended NPC tile in the overworld, open the Start Menu > NG PLUS > SHOW COORDINATES, and record the map ID, X, Y and facing. These are engine walk-grid cell coordinates, not screenshot pixels. Repeat at the Route 22 Blue Prime spot, the Indigo Plateau Dragon Master spot by the entrance, and the Red Echo statue garden spot. Send the three readings back for safe NPC placement. This option only reads the player's position; it does not teleport, modify maps, or affect progression.

**Blue Prime is implemented in v1.0.6 as an unverified test encounter.** The coordinate finder remains available for placing Dragon Master and Red Echo.

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
