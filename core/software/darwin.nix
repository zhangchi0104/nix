{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    # for react-native / ios
    cocoapods
  ];
  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "cursor"
      "android-platform-tools"
      "slack"
      "postman"
      "visual-studio-code"
      "1password"
      "raycast"
      "jordanbaird-ice"
    ];
    brews = [
      "livekit-cli"
    ];
  };
}
