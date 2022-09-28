class UserModel {
  final String? id;
  final String? token;
  final String? roleId;

  final String? roleName;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["user"]["id"].toString(),
        token: json["token"],
        roleId: json["user"]["role_id"].toString(),
        roleName: json["user"]["role"]["name"]);
  }
  UserModel({
    required this.id,
    required this.token,
    required this.roleId,
    required this.roleName,
  });
}
