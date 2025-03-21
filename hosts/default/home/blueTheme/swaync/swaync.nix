{ pkgs
, lib
, config
, ...
}: 

{
    services.swaync = {
        enable = true;
        settings = {
            positionX = "right";
            positionY = "top";
            fit-to-screen = false;
            control-center-margin-top = 10;
            # control-center-margin-bottom = 10;
            control-center-margin-right = 10;
            notification-icon-size = 64;
            control-center-width = 300;
            control-center-height = 300;
            notification-body-image-height = 100;
            notification-body-image-width = 200;
            widgets = ["dnd" "buttons-grid"];
            widget-config = {
                buttons-grid = {
                    actions = [
                      {
                        label = "󰐥";
                        command = "systemctl poweroff";
                      }
                      {
                        label = "󰜉";
                        command = "systemctl reboot";
                      }
                      {
                        label = "󰏥";
                        command = "systemctl suspend";
                      }
                      {
                        label = "󰌾";
                        command = "";
                      }
                    ];
                };
            };
        };
        style = ''
        .notification {
            background: #${config.stylix.base16Scheme.base00};
            border: 5px solid #${config.stylix.base16Scheme.base0D};
            border-radius: 15px;
            margin: 3px -2px 3px 0px;
        }
        .control-center {
            background: #${config.stylix.base16Scheme.base00};
            border: 2px solid #${config.stylix.base16Scheme.base0D};;
            border-radius: 15px;
            opacity: 1;
        }

       

        /* Focus Mode */

        .widget-dnd {
          background: @noti-bg-darker;
          padding: 5px 10px;
          margin: 5px 10px;
          border-radius: 15px;
          font-size: medium;
          color: #${config.stylix.base16Scheme.base0D};
        }


        .widget-dnd>switch {
          border-radius: 15px;
          background: #${config.stylix.base16Scheme.base0D};
        }

        .widget-dnd>switch:checked {
          background: #${config.stylix.base16Scheme.base08};
          border: 1px solid #${config.stylix.base16Scheme.base08};
        }

        .widget-dnd>switch slider {
          background: #${config.stylix.base16Scheme.base00};
          border-radius: 15px;
        }

        .widget-dnd>switch:checked slider {
          background: #${config.stylix.base16Scheme.base00};
          border-radius: 15px;
        }
        /* buttons grid */

        .widget-buttons-grid {
          font-size: x-large;
          padding: 5px;
          margin: 5px 10px 10px 10px;
          border-radius: 15px;
          background: @noti-bg-darker;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button {
          margin: 3px;
          background: @cc-bg;
          border-radius: 15px;
          color: @text-color;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button:hover {
          background: #${config.stylix.base16Scheme.base0D}; /* Changed from rgba(122, 162, 247, 1) to rgb format */
        }
               /* Style for the first button */
        .widget-buttons-grid > flowbox > flowboxchild:nth-child(1) > button {
            margin: 3px;
            background: #${config.stylix.base16Scheme.base08}; /* Red background */
            border-radius: 15px;
            color: #ffffff; /* White text */
        }
        .widget-buttons-grid>flowbox>flowboxchild:nth-child(1)>button:hover {
          background: #${config.stylix.base16Scheme.base0D}; 
        }

        /* Style for the second button */
        .widget-buttons-grid > flowbox > flowboxchild:nth-child(2) > button {
            margin: 3px;
            background: #${config.stylix.base16Scheme.base0B}; /* Green background */
            border-radius: 15px;
            color: #000000; /* Black text */
        }
        .widget-buttons-grid>flowbox>flowboxchild:nth-child(2)>button:hover {
          background: #${config.stylix.base16Scheme.base0D};                   
        }

        /* Style for the third button */
        .widget-buttons-grid > flowbox > flowboxchild:nth-child(3) > button {
            margin: 3px;
            background: #${config.stylix.base16Scheme.base0A}; /* Blue background */
            border-radius: 15px;
            color: #ffffff; /* White text */
        }
        .widget-buttons-grid>flowbox>flowboxchild:nth-child(3)>button:hover {
          background: #${config.stylix.base16Scheme.base0D};           
        }

        /* Style for the fourth button */
        .widget-buttons-grid > flowbox > flowboxchild:nth-child(4) > button {
            margin: 3px;
            background: #${config.stylix.base16Scheme.base07}; /* Yellow background */
            border-radius: 15px;
            color: #000000; /* Black text */
        }
        .widget-buttons-grid>flowbox>flowboxchild:nth-child(4)>button:hover {
          background: #${config.stylix.base16Scheme.base0D}; 
          color: @cc-bg;
        }




        '';
    };
}
