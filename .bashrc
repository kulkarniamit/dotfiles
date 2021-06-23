# Useful aliases
alias ll='ls -alF'
alias tl="tmux ls|cut -f 1 -d ':'"
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias uu='. uu '
alias rgrep='grep -I -n --exclude-dir=.svn -r'
alias rf="sudo rm -rvf"
alias pjq="python -m json.tool" # Show web responses in pretty json using Python module

# Auto correct typos in cd command path
shopt -s cdspell

function createrandomfile() {
# Create a file of given size with random bytes
    if [ $# -lt 1 ]; then
        echo "[ERR] Please enter the number of bytes for the file"
        echo -e "Usage: createrandomfile <number_of_bytes> [file_name]\n"
        return 1
    fi
    _bytes=$1
    _filename=${2:-$_bytes-bytes-file}
    echo "[LOG] Creating $_filename ($_bytes bytes)"
    < /dev/urandom tr -dc "[:alnum:]" | head -c$_bytes > $_filename
    echo -e "[LOG] File created: $_filename\n"
}

function fopen(){
    # Search for a file pattern in the current directory
    # Resulting files of find command are provided as arguments 
    # to vim command. They can be accessed in vim using buffers
    # Use :ls or :files or :buffers to see the list of files
    # opened
    find . -type f -name $1 -exec vim {} +
    # Replacing + with \; will execute vim command on all the 
    # result files
}

function pcalc(){
    # Use python interpreter as calculator
    # Advantage over normal echo $((3+6)):
    #   * Execute any python built-in function to print the result
    #   * Sample builtins: pow(), ord(), hex(), round(), max(), min(), chr()
    #   *                  ascii(), len(), [hex(ord(x)) for x in "abcd"]
    #   *                  and so on...
    python3 -c "print($1)"
}

function runin() {
    # Run a command (with args) in a given directory
    # Usage: runin <absolute_directory_path> <cmd>
    if [ ! -d "$1" ]; then
        echo "[ERR] $1: No such directory, please specify full path of a directory"
        return 1
    fi
    pushd $1 > /dev/null
    shift
    $@
    popd > /dev/null
}

function get-biggest-files(){
  # List the largest files of a given directory (default: top 5)
  if [ ! -z "$1" -a "$1" == "-h" ]; then
    echo "Usage: "
    echo "get-biggest-files [<directory_path>] [<listing_count>]"
    return
  fi
  PWD=$(pwd)"/"
  # Set the current directory path as default path
  DIR_PATH=${1:-$PWD}
  # Strip the trailing slash for consistent paths
  DIR_PATH=${DIR_PATH%/}
  # Debugging
  echo "Path to be searched: "$DIR_PATH
  du -hs "$DIR_PATH"/* | sort -rh | head -${2:-5}
}

