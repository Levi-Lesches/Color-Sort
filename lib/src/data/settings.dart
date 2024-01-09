import "utils.dart";

class Settings {
  int lastLevel = 0;
  Settings.fromJson(Json json) : 
    lastLevel = json["last_level"];

  Json toJson() => {
    "last_level": lastLevel,
  };
}
