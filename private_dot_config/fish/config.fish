# abbreviations
# apt / debian / ubuntu
abbr -a ls 'eza --long --header --icons --git'
abbr -a aguu 'sudo apt update  && sudo apt upgrade'
abbr -a agr 'sudo apt remove'
abbr -a agi 'sudo apt install -y'
# opensuse / zypper
abbr -a zin  'sudo zypper in -y'
abbr -a zup  'sudo zypper dup'
abbr -a zdel  'sudo zypper remove'
abbr -a zfd  'zypper search'


# customized prompt
# oh-my-posh init fish --config ~/.ohmyposh.json | source
starship init fish | source
# smarter cd
zoxide init fish | source
# auto correction of borked commands
thefuck --alias | source
# better shell history
atuin init fish | source


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/kevinh/.opam/opam-init/init.fish' && source '/home/kevinh/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
