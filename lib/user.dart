class User {
  final int? id;
  final String email;
  final String urlAvatar;
  final String firstName;
  final String lastName;

  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.urlAvatar,
  });

  String get fullName => "$firstName $lastName";

  static User fromMap(map) {
    return User(
      id: map["id"],
      email: map["email"],
      urlAvatar: map["avatar"],
      firstName: map["first_name"],
      lastName: map["last_name"],
    );
  }
}
