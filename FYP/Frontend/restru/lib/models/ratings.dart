class Ratings {
  final int id;
  final int rate;
  final String comment;
  final User? user;

  Ratings({required this.id, required this.rate, required this.comment, this.user});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      id: json['id'] as int,
      rate: json['rate'] as int,
      comment: json['comment'] as String,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rate'] = rate;
    data['comment'] = comment;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  final int id;
  final String username;

  User({required this.id, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    return data;
  }
}
