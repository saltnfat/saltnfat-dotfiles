#!/usr/bin/env nix-shell
#! nix-shell -i bash -p stow git

source install-lib.sh

PROJECT_NAME="jwy-gh0stzk-dotfiles"
REPO_NAME=$PROJECT_NAME
current_user_name=$USER
user_name=$current_user_name

if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
  echo "Verified this is NixOS."
  echo "-----"
else
  echo "This is not NixOS or the distribution information is not available."
  exit
fi

echo "Default options are in brackets []"
echo "Just press enter to select the default"

echo "-----"

###############################################################################

# Prompt user for type of host environment

option_one="nix-deskstar (desktop)"
option_two="nix-lappy (laptop)"
option_three="nix-vm (virtual machine)"
option_four="Specify host name"
option_five="New host"
use_new_host=false

PS3='Choose install option: '
options=("$option_one" "$option_two" "$option_three" "$option_four" "$option_five" "Quit")
select opt in "${options[@]}"; do
  case $opt in
  "$option_one")
    host_name="nix-deskstar"
    break
    ;;
  "$option_two")
    host_name="nix-lappy"
    break
    ;;
  "$option_three")
    host_name="nix-vm"
    break
    ;;
  "$option_four")
    read -rp "Enter Host Name:" new_host
    host_name=$new_host
    break
    ;;
  "$option_five")
    read -rp "Enter New Host Name:" new_host
    host_name=$new_host
    use_new_host=true
    break
    ;;

  "Quit")
    exit
    ;;
  *) echo invalid option ;;
  esac
done

echo "Host is set to $host_name"

echo "-----"

###############################################################################
# If creating a new host

if [ "$use_new_host" == true ]; then
  mkdir -p ./nix-config/hosts/"$host_name"
  cp ./nix-config/hosts/nix-vm/options.nix ./nix-config/hosts/"$host_name"/

  read -rp "Enter Your Username: [ $current_user_name ] " user_name_response
  if [ ! -z "$user_name_response" ]; then
    user_name=$user_name_response
  fi

  if [ "$current_user_name" != "$user_name" ]; then
    echo "This will create a hashedPassword for the new user in the options file."
    while true; do
      echo
      read -rp "Enter New User Password: " new_pass
      echo
      read -rp "Enter New User Password Again: " new_pass2
      if [ "$new_pass" == "$new_pass2" ]; then
        echo "Passwords Match. Setting password."
        user_password=$(mkpasswd -m sha-512 "$new_pass")
        escaped_user_password=$(echo "$user_password" | sed 's/\//\\\//g')
        sed -i "/^\s*hashedPassword[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_user_password\"#" ./nix-config/users/users.nix
        break
      fi
    done

    exit
  fi

  sed -i "/^\s*setHostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$host_name\"/" ./nix-config/hosts/"$host_name"/options.nix
  sed -i "/^\s*setUsername[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$user_name\"/" ./nix-config/hosts/"$host_name"/options.nix
  sudo nixos-generate-config --show-hardware-config >./nix-config/hosts/"$host_name"/hardware.nix
  git add ./nix-config/hosts/"$host_name"/

fi

###############################################################################
# Ask if user wants to do an express install

read -p "Do you want to do an express install [use defaults]? For a new host do not use express install!" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Nn]$ ]]; then

  read -p "Do you want to generate a hardware config? (First time install typically)" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    sudo nixos-generate-config --show-hardware-config >./nix-config/hosts/"$host_name"/hardware.nix
  fi
  echo ""

  read -rp "Enter Your Username: [ $current_user_name ] " user_name_response
  if [ ! -z "$user_name_response" ]; then
    user_name=$user_name_response
  fi
  echo ""

  if [ "$current_user_name" != "$user_name" ]; then
    echo "This will create a hashedPassword for the new user in the options file."
    while true; do
      echo
      read -rp "Enter New User Password: " new_pass
      echo
      read -rp "Enter New User Password Again: " new_pass2
      if [ "$new_pass" == "$new_pass2" ]; then
        echo "Passwords Match. Setting password."
        user_password=$(mkpasswd -m sha-512 "$new_pass")
        escaped_user_password=$(echo "$user_password" | sed 's/\//\\\//g')
        sed -i "/^\s*hashedPassword[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_user_password\"#" ./nix-config/users/users.nix
        break
      fi
    done

    sed -i "/^\s*setUsername[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$user_name\"/" ./nix-config/hosts/"$host_name"/options.nix
    sed -i "/^\s*setHostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$host_name\"/" ./nix-config/hosts/"$host_name"/options.nix

  fi

else
  # express install stuff here
  echo "-----"
  echo "Doing express install"

fi

###############################################################################
echo "-----"
echo "Symlinking dot (.config and .local) files using GNU Stow"
[ ! -d ~/.config ] && mkdir -p $XDG_CONFIG_HOME
[ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
[ ! -d ~/.local/share ] && mkdir -p ~/.local/share

cd $PROJECT_DIR/dots && stow -R config -t ~/.config/ -v
cd $PROJECT_DIR/dots && stow -R local -t ~/.local/ -v
cd $PROJECT_DIR || exit

fc-cache -rf

###############################################################################
echo "Now Going To Build $PROJECT_NAME, 🤞"

if [ "$user_name" != "$current_user_name" ]; then
  echo "Ensuring $PROJECT_NAME repository is in your users HOME directory."
  cd ... || exit
  cp -r $REPO_NAME /home/"$user_name"/
  sudo chown -R "$user_name":users /home/"$user_name"/$REPO_NAME
fi
sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$host_name\"/" ./flake.nix

echo "using the following host name: $host_name"
if sudo nixos-rebuild switch --flake .#"$host_name" --show-trace; then
  echo "-----"
  echo "$PROJECT_NAME Has Been Installed!"
fi

###############################################################################
echo "-----"
echo "Cleaning up..."
git restore ./flake.nix
echo "Done!"
