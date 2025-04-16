# RollFor - Murder Mittens Fork
An opinionated fork of [obszczymucha's extraordinary RollFor addon](https://github.com/obszczymucha/roll-for-vanilla) for Murder Mittens of Turtle WoW with some guild-specific changes.

Note that I'm not really paying attention to testing, documentation or code style. This means that things may break. Use at your own risk.

## Changes compared to original
- Item **notes** (edit at [RollFor/data/ItemNotesDB.lua](RollFor/data/ItemNotesDB.lua))
- **SR+ rolls** require you to add 10 to your roll for every SR+
- **TMOG trade** request announcement
- **Priority** loot recipients (e.g. for designated DE): `/rfprio add <PLAYER>`
- **Class announcements** on rolls (https://github.com/obszczymucha/roll-for-vanilla/pull/32 by @sica42)
- Rolling can now last up to **30s**
- `/rf config threshold <COLOUR>` can **override the master-loot threshold**. Set to `orange` to auto-loot everything that's not BoP.
- You can select an arbitrary target from the loot list, no need to go to `...` anymore
- Added a button to speed up the roll (instead of abruptly cancelling it)
- `/arf` can bypass HR items
- TMOG rolls are now `/roll 50` by default

### Roadmap
- [ ] Implement more of sica's changes
- [ ] Make addon compatible with TWoW launcher by default
- [ ] Show guild and guild rank in roll list
