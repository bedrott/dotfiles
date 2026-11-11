{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "btw";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

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

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";
 
  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."bed" = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "bed";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    fastfetch
    kitty
    prismlauncher
    cava
    obs-studio
    discord
    nemo
    mangohud
    nwg-look
    btop
    tty-clock
    mpv
    eog
    noctalia
    lavat
  ];
  
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; 

  programs.fish.enable = true;

  services.flatpak.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true; 
   };
    
  fileSystems."/mnt/otuka" = {
    device = "/dev/disk/by-uuid/8ACEB23ECEB221FD";
    fsType = "ntfs3";
    options = [ "rw" "uid=1000" "gid=100" "umask=000" "exec" "nofail" ];
   };

  system.stateVersion = "26.05";

}
