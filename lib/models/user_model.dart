
class UserModel {
  String id;
  String userFullName;
  String userEmail;
  String userProfileImage;
  String userProfilePublicId;
  String userPhoneNumber;
  String userGender;
  String userLanguage;
  String userRole;
  String userStatus;
  String userAccountStatus;
  String? createdAt;
  String? updatedAt;

  UserModel({
    required this.id,
    required this.userFullName,
    required this.userEmail,
    required this.userProfileImage,
    required this.userProfilePublicId,
    required this.userPhoneNumber,
    required this.userGender,
    required this.userLanguage,
    required this.userRole,
    required this.userStatus,
    required this.userAccountStatus,

    this.createdAt,
    this.updatedAt,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'], 
      userFullName: json['userFullName'], 
      userEmail: json['userEmail'], 
      userProfileImage: json['userProfileImage'], 
      userProfilePublicId: json['userProfilePublicId'], 
      userPhoneNumber: json['userPhoneNumber'], 
      userGender: json['userGender'], 
      userLanguage: json['userLanguage'], 
      userRole: json['userRole'], 
      userStatus: json['userStatus'], 
      userAccountStatus: json['userAccountStatus'],

      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }

}