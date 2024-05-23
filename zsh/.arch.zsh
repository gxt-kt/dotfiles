macos() {
  echo "This is a macOS system"
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

# # Detect whether current is Archlinux
# if [ "$(grep -E '^ID=' /etc/os-release | cut -d'=' -f2)" = "arch" ]; then
#     archlinux
# fi
#
# # Detect whether current is Ubuntu
# if [ "$(grep -E '^ID=' /etc/os-release | cut -d'=' -f2)" = "ubuntu" ]; then
#     ubuntu
# fi
#
# # Detect whether current is macos
# if [ "$(grep -E '^ID=' /etc/os-release | cut -d'=' -f2)" = "darwin" ]; then
#     macos
# fi
# # Detect whether current is macos
# if [ "$(uname)" = "Darwin" ]; then
#   macos
# fi

# Detect the current operating system
os_id=$(grep -E '^ID=' /etc/os-release | cut -d'=' -f2)
case "$os_id" in
    "arch") archlinux ;;
    "ubuntu") ubuntu ;;
    "darwin") macos ;;
    *) ;;
esac
