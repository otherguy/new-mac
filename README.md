# 💻 New Mac

The things I do when setting up a new Mac

## Initial setup

- [ ] Install and configure [Dropbox](https://www.dropbox.com/install) and let it sync
- [ ] Install [homebrew](https://brew.sh)
- [ ] Install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- [ ] Install [Brewfile](Brewfile) with `brew bundle install --no-lock`
- [ ] Copy all [`dotfiles`](dotfiles) to home directory and `hosts` to `/etc/hosts`
- [ ] Use [mackup](https://github.com/lra/mackup) to restore configs `mackup restore --verbose`
- [ ] Configure 1Password synced Vault
- [ ] Run [`.macos`](.macos) file `source .macos`
- [ ] Transfer `.gnupg` keyring and `.ssh` key files
- [ ] [Disable Ruby documentation parsing](http://mts.io/2015/04/19/fix-slow-gem-install/)
- [ ] Add `auth sufficient pam_tid.so` to `/etc/pam.d/sudo` for biometric `sudo` authentication
- [ ] ﹗ Reboot

## Alfred

- [ ] Configure [Alfred](https://www.alfredapp.com/) and enable it for `⌘`-double tap
- [ ] Enable sync via Dropbox

## Visual Studio Code

- [ ] Enable Settings Sync

## Finder

- [ ] Remove ~labels~ tags and clean up sidebar


## Install and configure

- [ ] [Apple TV Aerial Views Screen Saver](https://github.com/JohnCoates/Aerial)
- [ ] [Apple Watch `pam.d` auth plugin](https://github.com/biscuitehh/pam-watchid) (`pam_tid.so` needs to be first)
- [ ] [Apple watch screensaver](http://www.rasmusnielsen.dk/applewatch/)
- [ ] [Bartender](https://www.macbartender.com/)
- [ ] [Fantastical](https://flexibits.com/fantastical)
- [ ] [GPG Suite](https://gpgtools.org)
- [ ] [Hazel](https://www.noodlesoft.com) (and sync rules with Dropbox)
- [ ] [Ledger Live](https://www.ledger.com/ledger-live)
- [ ] [LiteIcon](http://freemacsoft.net/liteicon/)
- [ ] [Little Snitch](https://www.obdev.at/products/littlesnitch/index.html)
- [ ] [MailSuite](https://smallcubed.com)
- [ ] [Micro Snitch](https://www.obdev.at/products/microsnitch/index.html)
- [ ] [Pock](https://pock.dev)
- [ ] [Raycast](https://raycast.com)
- [ ] [Rubitrack](https://www.rubitrack.com)
- [ ] [Shifty](https://shifty.natethompson.io/en/)
- [ ] [Stop the Madness](https://underpassapp.com/StopTheMadness/)
- [ ] [TamperMonkey](https://www.tampermonkey.net)
- [ ] [Termius](https://termius.com)
- [ ] [Things](https://culturedcode.com/things/)
- [ ] [Viscosity](https://www.sparklabs.com/viscosity/)

## Dock

- [ ] Add commonly used apps to the Dock

## Other

- [ ] Transfer iMessages history (`~/Library/Messages`)
- [ ] Add email to lock message in `Security & Privacy` settings
- [ ] Disable Siri system wide, and remove Siri button from touch bar
- [ ] Disable Fantastical Advanced setting `Go to today after adding items`
- [ ] Block incoming port `80` using Little Snitch
- [ ] Configure iMessage and Facetime to allow receiving text messages
