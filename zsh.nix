{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      add ="git add";
      cat ="bat --plain";
      checkout = "git checkout";
      commit = "git commit -m";
      gst = "git status";
      l = "eza --icons=always";
      la = "eza --icons=always -lah";
      ll = "eza --icons=always -lh";
      ls = "eza --icons=always -l";
      push = "git push";
      status = "git status";
    };

    # Configure the Starship prompt
    initExtra = ''
      eval "$(starship init zsh)"
      
      # Enable zsh-autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      
      # Enable zsh-syntax-highlighting
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      
      # Enable fzf key bindings
      [ -f "${pkgs.fzf}/share/fzf/key-bindings.zsh" ] && source "${pkgs.fzf}/share/fzf/key-bindings.zsh"
      
      # Enable zsh completion
      autoload -U compinit
      compinit
    '';
  };

  home.packages = with pkgs; [
    starship                # Starship prompt
    zsh-autosuggestions     # Autosuggestions
    zsh-syntax-highlighting # Syntax highlighting
    fd
    fzf                     # Fuzzy finder
    eza                     # Better ls
  ];

  # Set Zsh as the default shell for the user
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
}
