class AppUser {
  String? authId;
  String? fullName;
  String? email;

  AppUser({this.authId, this.fullName, this.email});

  AppUser.fromFiresore(Map<String, dynamic>? data)
    : this(
        authId: data?['authId'],
        fullName: data?['fullName'],
        email: data?['email'],
      );

  Map<String, dynamic> toFirestore() {
    return {"authId": authId, "email": email, "fullName": fullName};
  }
}
