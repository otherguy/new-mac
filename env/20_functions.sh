#!/usr/bin/env zsh


# Run `dig` and display the most useful info
function digall() {
	dig +nocmd "$1" any +multiline +noall +answer;
}


# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Go to the root of the current git project, or just go one folder up
function up() {
  export git_dir="$(git rev-parse --show-toplevel 2> /dev/null)"
  if [ -z $git_dir ]
  then
    cd ..
  else
    cd $git_dir
  fi
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@";
	}
fi;

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}";
	local ip=$(ipconfig getifaddr en1);
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}

# Compare original and gzipped file size
function gz() {
	local origsize=$(wc -c < "$1");
	local gzipsize=$(gzip -c "$1" | wc -c);
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
	printf "orig: %d bytes\n" "$origsize";
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo "ERROR: Certificate not found.";
		return 1;
	fi;
}

# Normalize `open` across Linux, macOS, and Windows.
# This is needed to make the `o` function (see below) cross-platform.
if [ ! $(uname -s) = 'Darwin' ]; then
	if grep -q Microsoft /proc/version; then
		# Ubuntu on Windows using the Linux subsystem
		alias open='explorer.exe';
	else
		alias open='xdg-open';
	fi
fi

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# ################################
# Crappy functions written by Zell
# ################################
# Find port in use (used to kill pid)
function findpid () {
  lsof -i tcp:$@
}

# USed to kill pid
function killpid () {
  kill -9 $@
}

# Downloads a .mp3 file
function dlmp3 () {
  youtube-dl --extract-audio --audio-format mp3 $1
}

function dlmp4 () {
  youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $1
}

#############################################################################
#  Better `ping` support for various URL formats/protocols
#
#  @param $1 - hostname
#  EXAMPLE USAGE: `ping http://google.com/`
#############################################################################
original_ping="$(whence ping)"
function _ping() {
    local pingdomain="$1"
    shopt -s nocasematch # allow lowercase
    pingdomain=${pingdomain/#*:\/\/} # strip protocol
    pingdomain=${pingdomain/#*:*@/} # strip leading 'user:pass@'
    pingdomain=$(echo "${pingdomain//"?"//}") # remove '?'
    pingdomain="$(echo "$pingdomain" | cut -d/ -f 1)" # clear last '/'
	eval "$original_ping $pingdomain"
}
alias ping="_ping"

# Docker editor
function dedit() {
  IFS=$'\n\t'

  CNAME="$1"
  FILE_PATH="$2"

  TMPFILE="$(mktemp)"
  docker cp "${CNAME}:${FILE_PATH}" "${TMPFILE}"
  eval ${EDITOR} "${TMPFILE}"
  docker cp "${TMPFILE}" "${CNAME}:${FILE_PATH}"
  rm "${TMPFILE}"
}

# Alias minikube to a function to get some default start parameters
function minikube() {
	if [[ "$1" == "start" ]] ; then
		eval command minikube start "${@:2}" --extra-config=controller-manager.horizontal-pod-autoscaler-upscale-delay=10s --extra-config=controller-manager.horizontal-pod-autoscaler-downscale-delay=10s --extra-config=controller-manager.horizontal-pod-autoscaler-sync-period=1s --extra-config=controller-manager.horizontal-pod-autoscaler-downscale-stabilization=1m --extra-config=controller-manager.horizontal-pod-autoscaler-use-rest-clients=false --extra-config kubelet.enable-custom-metrics=true --extra-config=kubeadm.ignore-preflight-errors=SystemVerification
	elif [[ "$1" == "stop" ]] ; then
		eval command minikube stop "${@:2}"
	else
		eval command minikube "$@"
	fi
}

# Usage:
# $ ip 172.217.16.142
function ip() { /usr/local/bin/grc -es --colour=auto /usr/bin/whois -h whois.arin.net "n $@"; }

# Kill app running on port
# Usage: killport <port>
# Example: killport 3000
function killport { kill -9 $(lsof -n -i4TCP:$1 | grep LISTEN | awk '{print $2}') }

# Kill app hogging a Volume
# Usage: killvolume <volume>
# Example: killvolume /Volumes/Some\ Drive
function killvolume {
  readonly volume=${1:?"The volume must be specified."}
  sudo lsof $1 | awk '{print $2}' | tail +2 | uniq | xargs kill -HUP
}

function plist_diff() {
  a=$(plutil -convert xml1 -o - "$1")
  b=$(plutil -convert xml1 -o - "$2")

  # The -u flag displays line numbers with "+" and "-" (rather than ">" and "<").
  # The optional colordiff binary defaults to green/red.
  # Less -R is used to emulate vi.
  which colordiff &> /dev/null
  if [ $? == 0 ]; then
    diff -u <(echo "$a") <(echo "$b") "${@:3}" | colordiff | less -R
  else
    diff -u <(echo "$a") <(echo "$b") "${@:3}" | less -R
  fi
}

