{
    services.swaync = {
        enable = true;
        settings = {
            positionX = "right";
            positionY = "top";
            control-center-margin-top = 10;
            control-center-margin-bottom = 10;
            control-center-margin-right = 10;
            notification-icon-size = 64;
            control-center-width = 500;
            control-center-hight = 800;
            notification-body-image-height = 100;
            notification-body-image-width = 200;
        };
        style = ''
        notification {
            background: @cc-bg;
            border: 2px solid #34548a;
            border-radius: 15px;
            margin: 3px -2px 3px 0px;
        } 
        '';
    };
}
