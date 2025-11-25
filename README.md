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
- [ ] Configure 1Password and let it sync
- [ ] Set up shell secrets (see [Shell Secrets](#shell-secrets) below)
- [ ] Symlink (hard link) `hosts` to `/etc/hosts` with `sudo ln -f dotfiles/hosts /etc/hosts`
- [ ] Restore all [`dotfiles`](dotfiles):

      gfind dotfiles -mindepth 1 -maxdepth 1 -type d | xargs -L1 -I{} basename "{}" | xargs stow --dotfiles --no-folding --target ~/ --dir dotfiles  --verbose --adopt

- [ ] Reset the repo to apply the dotfiles from upstream

        git reset .

- [ ]  Set macOS Dock items and system defaults:

        dot dock
        dot macos
        dot icons

- [ ] Transfer `.gnupg` keyring and `.ssh` key files
- [ ] Add `auth sufficient pam_tid.so` to `/etc/pam.d/sudo` for biometric `sudo` authentication
- [ ] Install [programming languages with `sh ./mise.sh`](mise.sh).
- [ ] ❗ Reboot
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
- [ ] [Fantastical](https://flexibits.com/fantastical)
- [ ] [GPG Suite](https://gpgtools.org)
- [ ] [Hazel](https://www.noodlesoft.com) (and sync rules with Dropbox)
- [ ] [Little Snitch](https://www.obdev.at/products/littlesnitch/index.html)
- [ ] [Micro Snitch](https://www.obdev.at/products/microsnitch/index.html)
- [ ] [Raycast](https://raycast.com)
- [ ] [Rubitrack](https://www.rubitrack.com)
- [ ] [Shifty](https://shifty.natethompson.io/en/)
- [ ] [Stop the Madness](https://underpassapp.com/StopTheMadness/)
- [ ] [Termius](https://termius.com)
- [ ] [Things](https://culturedcode.com/things/)
- [ ] [Viscosity](https://www.sparklabs.com/viscosity/)

## Shell Secrets

Shell secrets (API tokens, etc.) are managed by [1Password Environments](https://developer.1password.com/docs/cli/secrets-environment-variables/) and served via a named pipe (FIFO) - they never touch disk.

### Setup

The `Local Shell (zsh) Secrets` environment should already exist in 1Password after sync. You just need to add the destination on this machine:

1. Open **1Password** desktop app
2. Go to **Developer** → **Environments** → **Local Shell (zsh) Secrets** (create it if it doesn't exist)
3. Click **Destinations** tab → **Add Destination** → **Local .env file**
4. Set the path to: `~/.dotfiles/env/.secrets`
5. Authorize when prompted

When you open a new shell, 1Password will prompt for Touch ID authentication. The secrets are then available as environment variables for that session.

See [`env/50_secrets.sh`](env/50_secrets.sh) for the loader script.

## Other

- [ ] Add email to lock message in `Show Message when Locked` in `Lock Screen` settings
- [ ] Disable Siri system wide, and remove Siri button from touch bar
- [ ] Configure iMessage and Facetime to allow receiving text messages

# iPad

This also works on iPad with [iSH](https://ish.app):

apk --update add stow gnupg gnupg-scdaemon

find dotfiles -mindepth 1 -maxdepth 1 -type d | xargs -I{} basename "{}" | xargs stow --dotfiles --target ~/ --dir dotfiles --no-folding --verbose --adopt
