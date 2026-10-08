# Changelog

## 1.0.8

- Added Dragon Master on Route 23 at (6,32) and Red Echo on Route 23 at (11,20).
- Both NPCs have locked dialogue and a battle confirmation prompt.
- Battles share existing NG+ challenge teams, rewards, unlocks, and victory tracking.
- Companion Trainer Rematch RoddSoft now bypasses all NG+ boss NPC interactions.
- Requires in-game testing; Red Echo's Route 23 map is inferred from the supplied coordinates.

## 1.0.6

- Added Blue Prime as a stationary, interactable overworld NPC at Route 22 (X=19, Y=4).
- Added locked dialogue before the eight NG+ Gym challenges are completed.
- Reused the existing Blue Prime boss team, victory tracking, and rewards when challenged in the overworld.
- Preserved original Route 22 rival encounters and the NG+ menu battle.
- Blue Prime NPC behavior requires in-game verification; Dragon Master and Red Echo NPCs are still pending coordinates.

## 1.0.5

- Added a read-only SHOW COORDINATES option to the active NG+ menu.
- Displays the current overworld map ID, player X/Y walk-grid coordinates, and facing direction for precise future boss NPC placement.
- Documented how to capture the Route 22 and Indigo Plateau boss locations.
- This is a coordinate-finder test release; overworld boss NPCs have not yet been added.

## 1.0.4

- Added `recordExternalVictory(game, challengeId)` compatibility API for external Gym Leader rematch victories.
- External Gym victories now count toward New Game Plus progression, menu DONE indicators, and optional boss unlocks without granting NG+ menu-specific rewards.
- Repeated external victory reports are idempotent; inactive NG+ and invalid challenge IDs are rejected.
- Added lightweight external victory regression tests.
- Documented the fork's mod ID and compatibility API in README.md.
- Trainer Rematch RoddSoft integration remains a separate follow-up; no changes were made to that repository.

## 1.0.0

- Added post-League New Game Plus activation.
- Added global trainer and natural wild encounter scaling.
- Added eight Gym Leader rematches.
- Added three optional bosses.
- Added persistent rewards and repeatable difficulty cycles.
