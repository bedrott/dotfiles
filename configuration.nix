{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";    
    efiSupport = true;
    useOSProber = true;     
  };

  networking.hostName = "btw";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";
 
  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.firefox.enable = true;

  users.users."criswic" = {
    isNormalUser = true;
    description = "criswic";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     kitty
     fastfetch
     nemo
     noctalia
     cava
     lavat
     nwg-look
     vscodium
     prismlauncher
     tty-clock
     wget
     git
     obs-studio
     discord
     eog
     mpv
   ];

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
   };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true; 
   };

  programs.bash = {
   interactiveShellInit = ''
     ${pkgs.fastfetch}/bin/fastfetch
    '';
   }; 

  system.stateVersion = "26.05";

}
