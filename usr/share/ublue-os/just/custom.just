setup-flatpaks:
  #!/usr/bin/env bash
  echo 'Installing flatpaks from the ublue recipe ...'
  flatpaks=$(yq -- '.firstboot.flatpaks[]' "/usr/share/ublue-os/recipe.yml")
  for pkg in $flatpaks; do \
      echo "Installing: ${pkg}" && \
      flatpak install --user --noninteractive flathub $pkg; \
  done

setup-gaming:
  echo 'Setting up gaming experience ... lock and load.'
  flatpak install -y --user \\
  io.github.antimicrox.antimicrox \\
  net.lutris.Lutris \\
  info.mumble.Mumble \\
  im.riot.Riot \\
  com.github.mtkennerly.ludusavi \\
  com.github.Matoking.protontricks \\
  com.discordapp.Discord \\
  com.feaneron.Boatswain \\
  org.freedesktop.Platform.VulkanLayer.MangoHud//22.08 \\
  org.freedesktop.Platform.VulkanLayer.OBSVkCapture//22.08 \\
  org.freedesktop.Platform.VulkanLayer.vkBasalt//22.08 \\
  com.heroicgameslauncher.hgl \\
  com.obsproject.Studio \\
  com.obsproject.Studio.Plugin.OBSVkCapture \\
  com.obsproject.Studio.Plugin.Gstreamer \\
  com.usebottles.bottles \\
  com.valvesoftware.Steam \\
  com.valvesoftware.Steam.Utility.gamescope \\
  net.davidotek.pupgui2
  flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications 
  flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam 
  flatpak override --user --env=MANGOHUD=1 com.heroicgameslauncher.hgl 

nix-me-up:
  echo 'Setting phasers to kill. Installing nix.'
  /usr/bin/ublue-nix-install

nix-devbox:
  echo 'Installing devbox!'
  curl -fsSL https://get.jetpack.io/devbox | bash

distrobox-bluefin:
  echo 'Creating Blufin Ubuntu distrobox ...'
  distrobox create --image ghcr.io/ublue-os/ubuntu-toolbox:latest -n bluefin -Y

distrobox-fedoraboxkit:
  echo 'Creating Fedora mutable environment'
  distrobox create --image ghcr.io/odintdh/fedoraboxkit:latest -n fedoraboxkit -Y

distrobox-universal:
  echo 'Creating Universal Development distrobox ...'
  distrobox create --image mcr.microsoft.com/devcontainers/universal:latest -n universal -Y

upgrade:
  rpm-ostree upgrade
  flatpak update -y
  distrobox upgrade -a

yafti:
  yafti /usr/share/ublue-os/firstboot/yafti.yml
