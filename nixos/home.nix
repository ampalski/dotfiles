{ inputs, config, pkgs, ... }:

{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";
  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    htop
    fastfetch
    wget
    curl
    gnumake
    stow
    unzip
    gcc
    ripgrep
    fd
    fzf
    kitty
    kdePackages.dolphin
    rofi
    hyprpaper
  ];

  home.file."${config.xdg.configHome}/rofi" = {
    source = ../rofi/.config/rofi;
    recursive = true;
  };
  
  home.file."${config.xdg.configHome}/swaync" = {
    source = ../swaync/.config/swaync;
    recursive = true;
  };

  home.file."${config.xdg.configHome}/ghostty" = {
    source = ../ghostty/.config/ghostty;
    recursive = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Andrew Palski";
      user.email = "ampalski@gmail.com";
      init.defaultbranch= "main";
    };
    # userName = "Andrew Palski";
    # userEmail = "ampalski@gmail.com";
    # extraConfig = {
    #   init.defaultbranch= "main";
    # };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];

    extraConfig = builtins.readFile ../hyprland/.config/hypr/hyprland.conf;

    systemd.variables = [ "--all" ];

    settings = {
      monitor = [ "eDP-1, 1920x1080@60, 0x0, 1" ];
      exec-once = [
        "hyprctl setcursor Bibata-Modern-Ice 22"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,22"
      ];
    };
  };
  programs.hyprlock = {
    enable = true;
    extraConfig = builtins.readFile ../hyprlock/.config/hypr/hyprlock.conf;
  };
  services.hypridle = {
    enable = true;
  };
  xdg.configFile."hypr/hypridle.conf".source = ../hypridle/.config/hypr/hypridle.conf;
  services.hyprpaper.enable = true;
  xdg.configFile."hypr/hyprpaper.conf".source = ../hyprpaper/.config/hypr/hyprpaper.conf;

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ../waybar/.config/waybar/style.css;
  };
  xdg.configFile."waybar/config".source = ../waybar/.config/waybar/config;

  programs.home-manager.enable = true;
}
