class UserDataModel {
  final String userId, name, email;

  UserDataModel({
    required this.userId,
    required this.name,
    required this.email,
  }); 
  // Factory constructor to create an instance from JSON
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['user_id'],
      name: json['name']  ,
      email: json['email'] ,
    );
  }
}
