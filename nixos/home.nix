{ config, pkgs, ... }:

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

  programs.home-manager.enable = true;
}
