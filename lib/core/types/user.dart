class User {
  final String email;
  final String uid;
  final String password;
  final String? displayName;
  final bool? isEmailVerified;
  final String? photoURL;
  final String? refreshToken;
  
  User({
    required this.email,
    required this.uid,
    required this.password,
    this.displayName,
    this.isEmailVerified,
    this.photoURL,
    this.refreshToken,
  });
}
