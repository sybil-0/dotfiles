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
# fedora 
abbr -a dnfi 'sudo dnf install -y'
abbr -a dnfr 'sudo dnf remove'
abbr -a dnfu 'sudo dnf upgrade'
abbr -a dnfs 'dnf search'
# fedora 
abbr -a pacin 'sudo pacman -S'
abbr -a pacrm 'sudo pacman -Rs'
abbr -a pacup 'sudo pacman -Syu'
abbr -a pacfd 'sudo pacman -Ss'
# git 
abbr -a gitscd 'git config credential.helper store'

# customized prompt
# oh-my-posh init fish --config ~/.ohmyposh.json | source
starship init fish | source
# smarter cd
zoxide init fish | source
# auto correction of borked commands
thefuck --alias | source
# better shell history
atuin init fish | source
