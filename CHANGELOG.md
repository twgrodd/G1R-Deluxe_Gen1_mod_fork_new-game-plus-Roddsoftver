# Changelog

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
