{...}:
{
  home-manager.users.sayid = {pkgs, ...}:
  {
    home.packages = with pkgs; [
      python312
      python312Packages.pip
      python312Packages.python-lsp-server
      python312Packages.isort
      python312Packages.black
      python312Packages.ruff
    ];
  };
}
