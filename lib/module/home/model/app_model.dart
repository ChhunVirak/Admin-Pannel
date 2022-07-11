class AppModel {
  String? appname;
  String? applink;
  String? icon;
  String? id;
  String? description;
  double? proccess;

  AppModel(
      {this.appname,
      this.applink,
      this.icon,
      this.id,
      this.description,
      this.proccess});

  AppModel.fromJson(Map<String, dynamic> json) {
    appname = json['appname'];
    applink = json['applink'];
    icon = json['icon'];
    id = json['id'];
    description = json['description'];
    proccess = json['proccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appname'] = appname;
    data['applink'] = applink;
    data['icon'] = icon;
    data['id'] = id;
    data['description'] = description;
    data['proccess'] = proccess;
    return data;
  }
}
