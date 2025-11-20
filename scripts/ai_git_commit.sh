#!/bin/zsh

git_commit_ai_message() {
    # Model can be passed via $1. Use the default model if no model is set
    # Possible models can be retrieved via $ llm models list
    model="${1:-$(llm models default)}"

    # Variables for spinner function
    _SPINNER_POS=0
    _TASK_OUTPUT=""

    # Colors
    RESET=$(tput sgr0)
    BOLD=$(tput bold)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    WHITE=$(tput setaf 7)

    trim() {
        local var="$*"
        # remove leading whitespace characters
        var="${var#"${var%%[![:space:]]*}"}"
        # remove trailing whitespace characters
        var="${var%"${var##*[![:space:]]}"}"
        printf '%s' "$var"
    }

    # Function to generate commit message
    generate_commit_message() {
        model="$1"
        diff="$2"

        read -r -d '' prompt <<-EOF
			Below is a git diff of all currently staged changes, created with the command "git diff --cached".

			First, think about how many files have been changed. Then, consider the nature of the changes.

			Write a concise, informative commit message title for these changes.

			You MUST follow all of these rules at all times:
			    * The title must be no more than 72 characters.
			    * The title must be in imperative mood.
			    * Avoid using the word "refactor".
			    * Mention the files that were changed, if necessary.
			    * ONLY IF there are changes to multiple files OR updates of multiple dependencies in one commit, include a
			      detailed commit description below the title. Leave a blank line between the title and the description.
			    * If the diff is only for a single file and it's not a dependency or lock file,  DO NOT include a description, ONLY the title.
			    * Do NOT add headers or any output before or after the commit title. Do not format the title like
			      a headline or a list item.
			    * Do not make up a message, ticket numbers or reasons (e.g. do not claim performance improvements if not proven).
			    * Do not include the name of the branch in the commit message.
			    * When describing multiple dependency updates, use a list and include the version number of each
			      dependency description (e.g. '- Upgrade \`x\` to version a.b.c).
			    * Do not include unnecessary information like referencing "This commit..." or "This file...".

			What you write will directly be passed to "git commit -m [message]", so ensure it's a valid commit message.

			---DIFF---
			${diff}
			---END DIFF---
EOF

        response=$(llm -m "${model}" "${prompt}")

        trim "${response}"
    }


    spinner() {
        FUNCTION_NAME="$2"
        VARIABLE_NAME="${3:-}"

        _TASK_OUTPUT=""
        local delay=0.05
        local list=( $(echo -e '\xe2\xa0\x8b')
                    $(echo -e '\xe2\xa0\x99')
                    $(echo -e '\xe2\xa0\xb9')
                    $(echo -e '\xe2\xa0\xb8')
                    $(echo -e '\xe2\xa0\xbc')
                    $(echo -e '\xe2\xa0\xb4')
                    $(echo -e '\xe2\xa0\xa6')
                    $(echo -e '\xe2\xa0\xa7')
                    $(echo -e '\xe2\xa0\x87')
                    $(echo -e '\xe2\xa0\x8f'))
        local i=$_SPINNER_POS
        local tempfile
        tempfile=$(mktemp)


        local pid  # Declare 'pid' at the top to make it accessible throughout the function

        # Detect whether we are in Zsh or Bash
        if [ -n "$ZSH_VERSION" ]; then
            # Zsh: Use &! to background and disown
            eval $FUNCTION_NAME >> $tempfile 2>/dev/null &!
            pid=$!  # Capture PID in Zsh
        else
            # Bash: Use & followed by disown, but capture PID first
            eval $FUNCTION_NAME >> $tempfile 2>/dev/null &
            pid=$!  # Capture PID before disowning in Bash
            disown
        fi

        tput sc
        printf "%s  %s" "${list[i]}" "$1"
        tput el
        tput rc

        i=$(($i+1))
        i=$(($i%10))

        while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
            printf "%s" "${CYAN}${list[i]}${RESET}"
            i=$(($i+1))
            i=$(($i%10))
            sleep $delay
            printf "\b\b\b"
        done
        _TASK_OUTPUT="$(cat $tempfile)"
        rm -f $tempfile
        _SPINNER_POS=$i

        if [ -z $VARIABLE_NAME ]; then :; else
            eval $VARIABLE_NAME=\'"$_TASK_OUTPUT"\'
        fi
    }

    # Function to read user input compatibly with both Bash and Zsh
    read_input() {
        if [ -n "$ZSH_VERSION" ]; then
            echo -n "$1"
            read -r REPLY
        else
            read -p "$1" -r REPLY
        fi
    }

    # Main script

    # Get the diff of all staged changes
    diff=$(git --no-pager diff --cached -M -C --no-color)
    diff=$(trim "$diff")

    # IF the diff is empty, cancel the commit
    if [ -z "$diff" ]; then
        echo "No changes to commit."
        return 1
    fi

    task() {
        generate_commit_message "$model" "$diff"
    }

    stty -echo && tput civis
    spinner "Generating commit message (${BOLD}${model}${RESET})" task commit_message
    tput el && tput cnorm && stty echo

    while true; do
        echo -e "\nProposed commit message: ${CYAN}${commit_message}${RESET}"

        read_input "\nDo you want to (${BOLD}a${RESET})ccept, (${BOLD}e${RESET})dit, (${BOLD}r${RESET})egenerate, or (${BOLD}c${RESET})ancel? "
        choice=$REPLY

        case "$choice" in
            a|A )
                if git commit -m "${commit_message}"; then
                    echo "Changes committed successfully!"
                    return 0
                else
                    echo "Commit failed. Please check your changes and try again."
                    return 1
                fi
                ;;
            e|E )
                read_input "Enter your commit message: "
                commit_message=$REPLY
                if [ -n "$commit_message" ] && git commit -m "$commit_message"; then
                    echo "Changes committed successfully with your message!"
                    return 0
                else
                    echo "Commit failed. Please check your message and try again."
                    return 1
                fi
                ;;
            r|R )
                stty -echo && tput civis
                spinner "Generating commit message (${BOLD}${model}${RESET})" task commit_message
                tput el && tput cnorm && stty echo
                ;;
            c|C )
                echo "Commit cancelled."
                return 1
                ;;
            * )
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}

git_commit_ai_message
