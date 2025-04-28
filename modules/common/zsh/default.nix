{lib, pkgs, ...}:

{
  users.users.sayid.shell = pkgs.zsh;
  programs.zsh.enable = true;
  home-manager.users.sayid = { pkgs, ... }: {
    programs = {
        zsh = {
            enable = true;
            syntaxHighlighting.enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            autocd = true;
            oh-my-zsh.enable = true;
            plugins = [
                {
                    name = "powerlevel10k";
                    src = pkgs.zsh-powerlevel10k;
                    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
                }
            ];
            initContent = lib.mkBefore ''
                # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
                # Initialization code that may require console input (password prompts, [y/n]
                # confirmations, etc.) must go above this block; everything else may go below.
                if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                fi
                ZSH_DISABLE_COMPFIX="true"
                export DIRENV_LOG_FORMAT="direnv: %s"
                export PATH=$PATH:/home/sayid/go/bin

                # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
                [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
                typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
                pfetch
            '';
            # initExtra = ''
            # '';
            shellAliases = {
                nix-update = "nix flake update";
            };
        };
    };
  };
}
