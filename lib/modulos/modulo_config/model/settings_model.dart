class SettingsModel {
  String name;
  String email;

  SettingsModel({required this.name, required this.email});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      name: json['name'],
      email: json['email'],
    );
  }
 
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
