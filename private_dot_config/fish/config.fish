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
