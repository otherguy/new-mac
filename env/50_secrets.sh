#############################################################################
# Secrets (managed by 1Password Environments)
#############################################################################
#
# This file sources secrets from a virtual .env file managed by 1Password.
# The actual secrets never touch disk - they're served through a UNIX pipe.
#
# Setup in 1Password:
#   1. Open 1Password desktop app
#   2. Go to Developer → Environments
#   3. Create a new environment (e.g., "Shell Secrets")
#   4. Add your secrets as key-value pairs, e.g.:
#        HOMEBREW_GITHUB_API_TOKEN=ghp_xxxx
#        NPM_TOKEN=npm_xxxx
#   5. Under Destinations, click "Add Destination" → "Local .env file"
#   6. Set the path to: ~/.dotfiles/env/.secrets
#   7. Authorize when prompted
#
# The .secrets file will be automatically mounted when 1Password is running
# and locked when 1Password locks.
#
#############################################################################

SECRETS_FILE="${DOTFILES_DIR:-$HOME/.dotfiles}/env/.secrets"
SECRETS_FILE="${SECRETS_FILE:A}"

if [[ -p "$SECRETS_FILE" || -f "$SECRETS_FILE" ]]; then
  set -a
  source "$SECRETS_FILE"
  set +a
else
  echo "\e[33m[warning]\e[0m Secrets file not found: $SECRETS_FILE"
  echo "          Is 1Password running? See setup instructions in 50_secrets.sh"
fi
