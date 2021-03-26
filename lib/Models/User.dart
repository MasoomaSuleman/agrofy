// user with custom fields in firebase

class User {
  String name;
  String email;
  String profession;
  String phoneNumber;
  String organization;
  String profileImageURL;

  User(
      {this.name,
      this.email,
      this.profession,
      this.phoneNumber,
      this.organization,
      this.profileImageURL});

  static Map<String, dynamic> toJson(User user) => {
        'name': user.name,
        'email': user.email,
        'profession': user.profession,
        'phoneNumber': user.phoneNumber,
        'organization': user.organization,
        'profileImageURl': user.profileImageURL
      };
}
