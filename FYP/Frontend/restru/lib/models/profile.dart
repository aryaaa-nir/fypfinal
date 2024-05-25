class Profile {
  int? id;
  String? allergy;
  String? phone;
  User? user;
  

  Profile({this.id, this.allergy, this.phone, this.user});

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        allergy = json['allergy'],
        phone = json['phone'],
        user = json['user'] != null ? User.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'allergy': allergy,
      'phone':phone,
      if (user != null) 'user': user!.toJson(),
    };
  }
}

class User {
  int? id;
  String? password;
  String? lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  String? dateJoined;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  User({
    this.id,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.groups,
    this.userPermissions,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        password = json['password'],
        lastLogin = json['last_login'],
        isSuperuser = json['is_superuser'],
        username = json['username'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        email = json['email'],
        isStaff = json['is_staff'],
        isActive = json['is_active'],
        dateJoined = json['date_joined'],
        groups = json['groups'],
        userPermissions = json['user_permissions'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'last_login': lastLogin,
      'is_superuser': isSuperuser,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'is_staff': isStaff,
      'is_active': isActive,
      'date_joined': dateJoined,
      'groups': groups,
      'user_permissions': userPermissions,
    };
  }
}
