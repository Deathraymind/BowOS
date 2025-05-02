{ pkgs, lib, ...}:
{
    services = {
        udisks2.enable = true;
        dbus.enable = true;

        # SSH
        openssh = {
            enable = true;
            settings = {
                PasswordAuthentication = true;
                PermitRootLogin = lib.mkForce "no";
            };
        };
    };

}
