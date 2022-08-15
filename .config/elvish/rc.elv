 # use github.com/muesli/elvish-libs/theme/powerline
# powerline:setup

# Alias
# FIXME
# fn co { |@args|
#   g++ -std=c++17 -O2 -o ${args[0]%.*} $@args -Wall;
# }



fn emacse {|@cmds|
  each {|c|
    emacsclient $c &
  } $cmds
}

# FIXME
# fn zathura [@_args]{
#   tabbed -c zathura $@_args &
# }

fn pacman {|@_args| sudo pacman $@_args }

fn rx { redshift -x }

fn nightmode { redshift -O 4500 -m randr -v }

# fn mc {
# java -jar ~/Downloads/TLauncher-2.72/TLauncher-2.839.jar
# }

fn mp {
  ncmpcpp
}

fn vanillamacs { |@_args|
  emacs $@_args --with-profile vanilla
}

fn nyxt {
  /home/prashant/common-lisp/nyxt/nyxt &
}

fn wallpaper {
  feh --bg-scale ~/Downloads/neon.png
}

# fn rofi [ ]{
#   e:rofi -show run
# }

fn v+ {
  amixer -D pulse set Master 5%+ unmute; notify-send Volume Up
}

fn v- {
  amixer -D pulse set Master 5%- unmute; notify-send Volume Down
}

fn mute {
  amixer -D pulse set Master Playback Switch toggle; notify-send Mute
}

fn b+ {
  xbacklight -inc 5; notify-send Brightness up
}

fn b- {
  xbacklight -dec 5; notify-send Brightness down
}

fn nm {
  redshift -O 5000
}


fn spoty {
  spotifyd --no-daemon > /dev/null &; spt
}

# FIXME
fn ytm { |@_link|
  youtube-dl --audio-quality 0 -i --extract-audio --audio-format mp3 -o './%(playlist_index)3d - %(title)s.%(ext)s' --add-metadata --embed-thumbnail --metadata-from-title "%(artist)s - %(title)s" $@_link
}

#edit prompts
set edit:prompt = { styled '~; ' yellow}

set edit:rprompt = { styled (tilde-abbr $pwd) blue inverse}

# FIXME Keybinding
set edit:insert:binding[Ctrl-L] = { clear > /dev/tty }

# Suppress output of successful jobs, keep the terminal tidy
set notify-bg-job-success = $false

# Fix for anki qt glx
# set E:QT_XCB_GL_INTEGRATION = none

# Env Vars
set E:SUDO_ASKPASS = "/usr/lib/ssh/x11-ssh-askpass"

set E:SSH_ASKPASS = "ssh-askpass"

# Guix
# set E:GUIX_PROFILE = "/home/prashant/.guix-profile"

set E:GUIX_PROFILE = "/home/prashant/.config/guix/current"
set E:NIX_PROFILE = "/home/prashant/.nix-profile"

# PATH
set paths = [
  ~/.local/bin
  /usr/lib/jvm/default/bin
  /usr/bin/site_perl
  /usr/bin/vendor_perl
  /usr/bin/core_perl
  /usr/lib/ssh
  ~/bin
  ~/doom-emacs/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /usr/bin
  /bin
  ~/emacs-native-comp/bin
  $E:GUIX_PROFILE/etc/profile
  $E:NIX_PROFILE/bin
]
