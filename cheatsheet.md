# Neovim cheat sheet

`<leader>` = `Space`  ·  Press `Space` and wait to see what's possible  ·  `Space s k` searches every keymap  ·  `q` closes this

## Finding things
| Key | Action |
|---|---|
| `Space Space` | Open buffers |
| `Space s f` | Files |
| `Space s t` | Grep text |
| `Space s w` | Grep word under cursor / selection |
| `Space /` | Search lines in current buffer |
| `Space s /` | Grep in open buffers |
| `Space s .` | Recent files |
| `Space s r` | Resume last search |
| `Space s s` | List all pickers |
| `Space s d` / `s D` | Diagnostics (project / buffer) |
| `Space s h` / `s k` / `s c` | Help / keymaps / commands |
| `Space s u` | Undo history |
| `Space s j` / `s m` / `s "` | Jumps / marks / registers |
| `Space s n` | Files in this Neovim config |
| `Space t n` | Toggle file explorer |
| `Space e` | Reveal current file in explorer |

## Moving around
| Key | Action |
|---|---|
| `gs` | Flash: jump anywhere (type 2 chars, then the label) |
| `gS` | Flash: select a treesitter node |
| `r` / `R` (after `d`, `y`, `c`…) | Remote flash / treesitter search |
| `Ctrl h j k l` | Move between windows |
| `[b` / `]b` | Previous / next buffer |
| `[d` / `]d` | Previous / next diagnostic |
| `[q` / `]q` | Previous / next quickfix item |
| `[c` / `]c` | Previous / next git change |
| `[t` / `]t` | Previous / next failed test |
| `Ctrl o` / `Ctrl i` | Jump back / forward |

## Code (LSP)
| Key | Action |
|---|---|
| `grd` | Go to definition |
| `grr` | References |
| `gri` | Implementations |
| `grt` | Type definition |
| `grD` | Declaration |
| `grc` | Incoming calls |
| `K` | Hover docs |
| `grn` | Rename symbol |
| `gra` | Code action (normal + visual) |
| `gO` / `gW` | Document / workspace symbols |
| `Ctrl w d` | Diagnostic under cursor |
| `Space f` | Format buffer (also on save) |
| `Space q` | Diagnostics to location list |
| `Space t h` | Toggle inlay hints |
| `Space c R` | Rename file (updates imports) |
| `Space c v` | Select Python virtualenv |
| `Space j q` | Format JSON with jq |

## Editing
| Key | Action |
|---|---|
| `Ctrl y` | Accept completion |
| `Ctrl Space` | Open completion / docs |
| `Ctrl n` / `Ctrl p` | Next / previous completion item |
| `Ctrl e` | Close completion |
| `Ctrl k` / `Ctrl s` (insert) | Signature help |
| `Tab` / `Shift Tab` | Jump through snippet fields |
| `gcc` / `gc{motion}` | Toggle comment |
| `sa{motion}{char}` | Add surround — `saiw)` wraps word in `()` |
| `sd{char}` | Delete surround — `sd'` |
| `sr{old}{new}` | Replace surround — `sr)'` |
| `va)` `ci'` `yinq` | Around/inside text objects (`q` quote, `b` bracket, `f` function call, `a` argument) |
| `ih` | Git hunk text object — `dih`, `vih` |
| `[Space` / `]Space` | Add empty line above / below |

## Git
| Key | Action |
|---|---|
| `Space g g` | Lazygit |
| `Space g s` | Status |
| `Space g d` | Toggle diff view (changes, merge conflicts) |
| `Space g D` | Branch vs default branch (PR review) |
| `Space g h` / `g H` | File history / branch history |
| `Space g l` / `g L` / `g f` | Log / log for line / log for file |
| `Space g b` / `g S` | Branches / stash |
| `Space g p` | GitHub pull requests |
| `Space g B` | Open in GitHub |
| `Space h s` / `h r` | Stage / reset hunk (works on a selection) |
| `Space h S` / `h R` | Stage / reset buffer |
| `Space h p` / `h i` | Preview hunk (popup / inline) |
| `Space h b` | Blame line |
| `Space h d` / `h D` | Diff against index / last commit |
| `Space b l` | Toggle inline blame |
| `Space t w` | Toggle word diff |

## Debugging
| Key | Action |
|---|---|
| `F5` / `Space d c` | Start / continue |
| `F10` / `Space d o` | Step over |
| `F11` / `Space d i` | Step into |
| `F12` / `Space d O` | Step out |
| `Space d b` / `d B` | Breakpoint / conditional breakpoint |
| `Space d C` | Run to cursor |
| `Space d e` | Evaluate under cursor |
| `Space d w` | Watch expression |
| `Space d v` | Toggle debug view |
| `Space d l` / `d t` | Run last / terminate |

## Tests
| Key | Action |
|---|---|
| `Space r r` | Run nearest test |
| `Space r f` / `r A` | Run file / all tests |
| `Space r d` | Debug nearest test |
| `Space r l` | Run last |
| `Space r s` | Test summary |
| `Space r o` / `r O` | Output / output panel |
| `Space r w` | Watch file |
| `Space r x` | Stop |

## Claude Code
| Key | Action |
|---|---|
| `Space a c` / `a f` | Toggle / focus Claude |
| `Space a r` / `a C` | Resume / continue a session |
| `Space a s` (visual) | Send selection |
| `Space a b` | Add current buffer |
| `Space a s` (in explorer) | Add file |
| `Space a a` / `a d` | Accept / deny proposed diff |
| `Space a m` | Choose model |

## Buffers, windows, misc
| Key | Action |
|---|---|
| `Space b d` | Delete buffer (keeps layout) |
| `Ctrl /` | Toggle terminal |
| `Esc Esc` (terminal) | Leave terminal mode |
| `Esc` | Clear search highlight |
| `Space u n` | Dismiss notifications |
| `Space s N` | Notification history |
| `Space s p` | Search plugin specs |
| `Space ?` | This cheat sheet |
