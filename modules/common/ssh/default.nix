{...}:
{
    programs.ssh.askPassword = "";
    programs.mosh.enable = true;
    services.openssh = {
        enable = true;
        settings = {
            PasswordAuthentication = false;
        };
    };
    users.users.sayid.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINqFi6txBF5FtkV10/LKMsxUK82PMbFpEYZJF2g7fYCP sayid@Sayids-MacBook-Pro.local" # mbp 16
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAXcXK+YA7v9l/wVNUC5+i2r8rWeqx5KID6x+DhSftfE sayid@nixos" # main pc
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDppKCmUpwmycNKIKEgkYuk2nu4JP6ToGZLBPKiRqA+L sayid@sayids-MacBook-Air.local" #mba m2 mac
    ];
}
