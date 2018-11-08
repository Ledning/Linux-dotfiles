#-----------------------------------------------
#
# general & zsh config
#-----------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH=/home/hackerman/.oh-my-zsh

ZSH_THEME="honukai"
plugins=(git)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/bin/core_perl:/home/pgug/.gem/ruby/2.4.0/bin:$HOME/.cask/bin:$HOME/.config/composer/vendor/bin:$PATH"
source $ZSH/oh-my-zsh.sh

export LANG=en_DK.UTF-8
export EDITOR=vim
export VISUAL=vim

# Awesome autocompletion
zstyle ':completion:*' rehash true
plugins+=(zsh-completions colored-man-pages)
autoload -U compinit && compinit

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

#-----------------------------------------------
#
# Aliases
#-----------------------------------------------

alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias i3config='vim ~/.config/i3/config'
alias reload='source ~/.zshrc'

alias ls='ls --color=auto'
alias cls='clear && ls'
alias ccc='clear && clear && clear'
alias sf='clear && screenfetch'
alias tellme='clear && screenfetch && echo && free -h && echo && df -h'
alias you2mp3='youtube-dl -x --audio-format mp3'
alias clean-branches='git remote prune origin'
alias please='sudo $(fc -ln -1)'
alias ping-google='ping 8.8.8.8'
alias bored='fortune -a | fmt -80 -s | $(shuf -n 1 -e cowsay cowthink) -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n'
alias tmux='TERM=screen-256color-bce tmux'
alias :q='exit'
alias fix-caps='setxkbmap -option caps:escape'
alias po='poweroff'
alias clean-madoko='rm ellipse.sty longbox.sty longfbox.sty madoko2.sty madoko.css options.sty'
alias madoko='madoko --odir=.'
alias whatsmyip='curl -4 icanhazip.com'
alias tcpdump='sudo tcpdump -i'
alias iwconfig='iwconfig wlan0'
alias psmem='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3 | head -10'
alias ccat='pygmentize -g'
alias remove-exif='exiftool -all= -overwrite_original'
alias show-exif='exiftool'
#alias b='pkexec mate-power-backlight-helper --set-brightness'
alias restart-network='sudo systemctl restart NetworkManager && sleep 12 && ping -v 8.8.8.8'

hackermode()
{
    if [[ "$1" == 'activated' ]]; then
        sudo anonsurf start
        killall -9 firefox > /dev/null 2> /dev/null
        firefox -P Pentest > /dev/null 2> /dev/null &
        echo 'Hackermode activated.' | figlet
    fi

    if [[ "$1" == 'deactivated' ]]; then
        sudo anonsurf stop
        killall -9 firefox > /dev/null 2> /dev/null
        echo 'Nothing to see here, officer' | figlet
    fi
}



alias fireprof='firefox -ProfileManager'

alias o='~/Scripts/gaptoggle.sh'

alias urldecode='python -c "import sys, urllib as ul; \
    print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(sys.argv[1])"'

# Latex
alias latex-compile='latexmk -silent -pdf -f master.tex'
alias latex-clean='latexmk -c master.tex && rm master.bbl master.thm'

# Passwords
alias password-urandom='strings /dev/urandom | cat /dev/urandom| tr -dc "a-zA-Z0-9-_!@#$%&*()_+{}:<>?=" | fold -w 15| head -n 4'
alias password-random='strings /dev/urandom | cat /dev/random| tr -dc "a-zA-Z0-9-_!@#$%&*()_+{}:<>?=" | fold -w 15| head -n 1'
alias password-pwqgen='pwqgen random=85'
alias random-word='shuf -n 8 /usr/share/dict/words'

password-simple-long()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

# Random mac
random-macaddress()
{
	sudo ifconfig $1 down
	sudo macchanger -A $1
	sudo ifconfig $1 up
}
compdef _ifconfig random-macaddress

imissmymac()
{
	sudo ifconfig $1 down
	sudo macchanger --permanent $1
	sudo ifconfig $1 up
}
compdef _ifconfig imissmymac

whatmac()
{
	macchanger --show $1
}
compdef _ifconfig whatmac

# Whats my intern IP
myintip()
{
	ifconfig | awk '/inet / && $2 != "127.0.0.1" { print $2 }'
}

utimedecode()
{
	date -d "@$1"
}

decodebase64()
{
	echo $1 | base64 -d
}
awesome-hexdump()
{
	hexdump -v -e '"|" 50/1 "%_p" "|\n"' $1
}

geolocate_ip()
{
	locbool=1
	echo -e ""$BS"Please wait..."$CE""
	A1="$1"
	if [[ 1 = 1 ]]
	then
		country=$(curl ipinfo.io/"$A1"/country 2>/dev/null)
		if [[ "$country" = "" ]]
		then
			country=""$RS"Not found"$CE""
		fi
		loc=$(curl ipinfo.io/"$A1"/loc 2>/dev/null)
		if [[ "$loc" = "" ]]
		then
			locbool=0
			loc=""$RS"Not found"$CE""
		fi
		city=$(curl ipinfo.io/"$A1"/city 2>/dev/null)
		if [[ "$city" = "" ]]
		then
			city=""$RS"Not found"$CE""
		fi
		org=$(curl ipinfo.io/"$A1"/org 2>/dev/null)
		if [[ "$org" = "" ]]
		then
			org=""$RS"Not found"$CE""
		fi
		postal=$(curl ipinfo.io/"$A1"/postal 2>/dev/null)
		if [[ "$postal" = "" ]]
		then
			postal=""$RS"Not found"$CE""
		fi
		region=$(curl ipinfo.io/"$A1"/region 2>/dev/null)
		if [[ "$region" = "" ]]
		then
			region=""$RS"Not found"$CE""
		fi
		hostname=$(curl ipinfo.io/"$A1"/hostname 2>/dev/null)
		if [[ "$hostname" = "" ]]
		then
			hostname=""$RS"Not found"$CE""
		fi
		echo -e "     Country: $country"
		echo -e "      Region: $region"
		echo -e "    Location: $loc"
		echo -e "        City: $city"
		echo -e "      Postal: $postal"
		echo -e "    Hostname: $hostname"
		echo -e "Organization: $org"
		if [[ "$locbool" = 0 ]]
		then
			echo -e ""$RS" m"$CE") Open google maps location"
		else
			echo -e ""$YS" m"$CE") Open google maps location"
		fi
		echo -e ""$YS" *"$CE") Go back"
		echo -e "Choose: "
		read ge
		if [[ "$ge" = "m" ]]
		then
			if [[ "$locbool" = 0 ]]
			then
				echo -e ""$RS"Location was not found"$CE""
				sleep 3
			else
				gio open https://www.google.gr/maps/search/"$loc"/
			fi
		fi
	fi
}

update-system()
{
	sudo apt update
	sudo apt full-upgrade
	sudo apt dist-upgrade
	sudo apt clean
	sudo apt autoclean
	sudo apt autoremove

	#sudo snap refresh
	#sudo npm update -g
	#flatpak update
	#sudo pip install --upgrade pip
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

