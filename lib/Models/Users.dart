class Users{
  final String userId;
  final String userName;
  final String userMail;
  final String userPassword;
  final String userType;

  const Users({
    required this.userId,
    required this.userName,
    required this.userMail,
    required this.userPassword,
    required this.userType
  });

  factory Users.fromjson(Map<String, dynamic> json) => Users(
    userId: json["userId"] == null ? "": json["userId"],
    userName: json["userName"] == null ? "" : json["userName"],
    userMail: json["userMail"] == null ? "" : json["userMail"],
    userPassword: json["userPassword"] == null ? "" : json["userPassword"],
    userType: json["userType"] == null ? "" : json["userType"]
  );

  Map<String, dynamic> toMap(){
    return {
      "userId": userId,
      "userName": userMail,
      "userPassword": userPassword,
      "userType": userType
    };
  }
}