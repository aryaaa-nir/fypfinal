class OrderTrack {
  int? id;
  String? createdAt;
  String? status;
  User? user;

  OrderTrack({this.id, this.createdAt, this.status, this.user});

  OrderTrack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
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
