{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    # for react-native / ios
    cocoapods
  ];
}
