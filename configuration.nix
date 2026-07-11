{ config, lib, pkgs, inputs, ... }:

{

  imports =
    [
      ./hardware-configuration.nix
    ];


  #---------- Xdg Shi ------------#

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];


  #------------- Nix -------------#
  
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  #---------- Bootloader ----------#

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";


  #----------- Network -----------#
  
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;


  #------------ Time ------------#

  time.timeZone = "Africa/Casablanca";


  #----------- Local -----------#

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };


  #---------- Services ----------#

  #services.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "greeter";
      };
    };
  };

  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };

   services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
  };
  

  #----------- Users ------------#

  users.users.legend = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };


  #----------- Programs -----------#

  programs.dconf.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.thunar.enable = true;
  programs.nix-ld.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  programs.fish.shellAliases = {
    nrebuild = "sudo nixos-rebuild switch";
    nconfig = "sudo codium /etc/nixos/configuration.nix";
  };

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    gtk3
    glib
    nss
    nspr
    dbus
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    pango
    gdk-pixbuf
    libdrm
    mesa
    alsa-lib
    cups
    expat
    fontconfig
    freetype
    libxkbcommon
    systemd
    pipewire
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    xorg.libxshmfence
    zlib
  ];


  #----------- UserPkgs -----------#
  
  environment.systemPackages = with pkgs; [
    vim
    kdePackages.breeze
    wget
    git
    vscodium
    alacritty
    waybar
    btop
    wofi
    hyprpolkitagent
    hyprpaper
    fastfetch
    grim
    slurp
    pkgs.fetch
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    tuigreet
    pkgs.amberol
    parabolic
    lollypop
    tauon
    spotube
    hyprpicker
    playerctl
    clock-rs
  ];


  #----------- Hardware -----------#

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.variables = {
    XCURSOR_THEME = "Breeze";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";      
    MOZ_ENABLE_WAYLAND = "1";
  };
  

  #------------ Fonts ------------#

  fonts = {
  packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "JetBrainsMono Nerd Font" ];
        serif = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };


  #---------- System Shi ----------#

  system.stateVersion = "26.05";


}

