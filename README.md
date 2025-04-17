# RollFor - Murder Mittens Fork
An opinionated fork of [obszczymucha's extraordinary RollFor addon](https://github.com/obszczymucha/roll-for-vanilla) for Murder Mittens of Turtle WoW with some guild-specific changes.

Note that I'm not really paying attention to testing, documentation or code style. This means that things may break. Use at your own risk.

## Changes compared to original
- Item **notes** (edit at [RollFor/itemnotes](RollFor/itemnotes))
- **SR+ rolls** require you to add 10 to your roll for every SR+
- **TMOG trade** request announcement
- **Priority** loot recipients (e.g. for designated DE): `/rfprio add <PLAYER>`
- **Class announcements** on rolls (https://github.com/obszczymucha/roll-for-vanilla/pull/32 by @sica42)
- Rolling can now last up to **30s**
- You can **override the auto-loot threshold**
- You can select an arbitrary target from the loot list, no need to go to `...` anymore
- Loot frame is automatically positioned at cursor ([`76993f2`](https://github.com/sica42/roll-for-vanilla/commit/76993f227733fbeb1f02cb45cd40d8b9eb40ad60) by @sica42)
- Added a button to speed up the roll (instead of abruptly cancelling it)
- `/htr` will show SR+ rolling instructions
- `/arf` can bypass HR items
- TMOG rolls are now `/roll 50` by default

## New configuration options
- `/rf config threshold` (default unset): Overrides the master loot threshold. Set to `orange` to auto-loot everything that's not BoP.
- `/rf config sr-plus-strategy` (default `PlayerAddsRoll`): Sets how SR+ is added to the roll. Possible options:
    - `PlayerAddsRoll`: Players have to manually add the proper number to their roll
    - `AddonHandlesPlus`: The addon adds the SR+ bonus automatically
    - `Ignore`: Does nothing. Will still show the SR+ to you if available.
- `/rf config sr-plus-multiplier` (default 10): Sets the SR+ multiplier (e.g. 10 means that you add +10 to your roll for each SR+ accumulated)
- `/rf config notes-source` (default `MurderMittens`): Sets where to fetch item notes from.
- `/rf config loot-frame-cursor` (default true): Toggles loot frame being positioned at cursor location.

### Roadmap
- [ ] Implement more of sica's changes
- [ ] Make addon compatible with TWoW launcher by default
- [ ] Show guild and guild rank in roll list
