{...}:
{
    home-manager.users.sayid = {pkgs, ...}: {
        home.packages = with pkgs; [
	        monero-gui
	    ];
    };
}