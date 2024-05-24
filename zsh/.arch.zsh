macos() {
  export LC_ALL=en_US.UTF-8  
  export LANG=en_US.UTF-8
}

archlinux() {
  #🔽🔽🔽
  # Autostart X at login
  # Ref : https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login
  if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
  fi
  #🔼🔼🔼
  
  # soft ware
  #🔽🔽🔽
  alias clion='nohup /opt/clion/clion-2023.2.1/bin/clion.sh&>/dev/null'
  #🔼🔼🔼
}

ubuntu() {
  
}

if [ -f "/etc/os-release" ]; then
  # Detect whether current is Archlinux
  if [ "$(grep -E '^ID=' /etc/os-release | cut -d'=' -f2)" = "arch" ]; then
      archlinux
  fi
  # Detect whether current is Ubuntu
  if [ "$(grep -E '^ID=' /etc/os-release | cut -d'=' -f2)" = "ubuntu" ]; then
      ubuntu
  fi
fi

# Detect whether current is macos
if [ "$(uname)" = "Darwin" ]; then
  macos
fi
