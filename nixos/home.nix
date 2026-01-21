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
  ];

  
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

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];
  };
  programs.home-manager.enable = true;
}
