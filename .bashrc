# Useful aliases
alias ll='ls -alF'
alias tl="tmux ls|cut -f 1 -d ':'"
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias svni='svn info'
alias svns='svn stat -q'
alias uu='. uu '
alias rgrep='grep -I -n --exclude-dir=.svn -r'
alias rf="sudo rm -rvf"

# Auto correct typos in cd command path
shopt -s cdspell

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
