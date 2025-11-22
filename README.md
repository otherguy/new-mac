# 💻 New Mac

The things I do when setting up a new Mac

## Initial setup

- [ ] Set up Touch ID
- [ ] Install XCode command line tools with `xcode-select --install`
- [ ] Install Rosetta 2 with `sudo softwareupdate --install-rosetta`
- [ ] Install [homebrew](https://brew.sh)
- [ ] Install GitHub's `gh` utility with `brew install gh` and login with `gh auth login`
- [ ] Clone this repo: `gh repo clone otherguy/new-mac ~/.dotfiles`
- [ ] Install [Brewfile](Brewfile) with `brew bundle install`
- [ ] Symlink (hard link) `hosts` to `/etc/hosts` with `sudo ln -f dotfiles/hosts /etc/hosts`
- [ ] Restore all [`dotfiles`](dotfiles):

      gfind dotfiles -mindepth 1 -maxdepth 1 -type d | xargs -L1 -I{} basename "{}" | xargs stow --dotfiles --no-folding --target ~/ --dir dotfiles  --verbose --adopt

- [ ] Reset the repo to apply the dotfiles from upstream

        git reset .

- [ ]  Set macOS Dock items and system defaults:

        dot dock
        dot macos

- [ ] Transfer `.gnupg` keyring and `.ssh` key files
- [ ] Add `auth sufficient pam_tid.so` to `/etc/pam.d/sudo` for biometric `sudo` authentication
- [ ] Install [programming languages with `sh ./mise.sh`](mise.sh).
- [ ] ❗ Reboot
- [ ] Configure 1Password and let it sync
- [ ] Install and configure [~Dropbox~ Maestral](https://www.dropbox.com/install) and let it sync

Learn the YubiKey serial number and create the stubs to point to the GPG keyID and Yubikey Serial number

```bash
gpg --card-edit
# then in the gpg prompt:
# > fetch
# > verify
# > quit
gpg-connect-agent "scd serialno" "learn --force" /bye
gpg-connect-agent updatestartuptty /bye
```

## Raycast

- [ ] Configure [Raycast](https://www.raycast.com) and enable it for `⌘`-double tap
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

- [ ] Add email to lock message in `Show Message when Locked` in `Lock Screen` settings
- [ ] Disable Siri system wide, and remove Siri button from touch bar
- [ ] Disable Fantastical Advanced setting `Go to today after adding items`
- [ ] Block incoming port `80` using Little Snitch
- [ ] Configure iMessage and Facetime to allow receiving text messages

# iPad

This also works on iPad with [iSH](https://ish.app):

apk --update add stow gnupg gnupg-scdaemon

find dotfiles -mindepth 1 -maxdepth 1 -type d | xargs -I{} basename "{}" | xargs stow --dotfiles --target ~/ --dir dotfiles --no-folding --verbose --adopt
