// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String? displayName;
  final String? photoURL;
  final String? email;
  final bool? emailVerified;
  final bool? isAnonymous;
  final String? phoneNumber;
  final String? refreshToken;
  final String? tenantId;
  final String? uid;

  User({
    this.displayName,
    this.photoURL,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.phoneNumber,
    this.refreshToken,
    this.tenantId,
    this.uid,
  });

  User copyWith({
    String? displayName,
    String? photoURL,
    String? email,
    bool? emailVerified,
    bool? isAnonymous,
    String? phoneNumber,
    String? refreshToken,
    String? tenantId,
    String? uid,
  }) {
    return User(
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      refreshToken: refreshToken ?? this.refreshToken,
      tenantId: tenantId ?? this.tenantId,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'photoURL': photoURL,
      'email': email,
      'emailVerified': emailVerified,
      'isAnonymous': isAnonymous,
      'phoneNumber': phoneNumber,
      'refreshToken': refreshToken,
      'tenantId': tenantId,
      'uid': uid,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      emailVerified:
          map['emailVerified'] != null ? map['emailVerified'] as bool : null,
      isAnonymous:
          map['isAnonymous'] != null ? map['isAnonymous'] as bool : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
      tenantId: map['tenantId'] != null ? map['tenantId'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(displayName: $displayName, photoURL: $photoURL, email: $email, emailVerified: $emailVerified, isAnonymous: $isAnonymous, phoneNumber: $phoneNumber, refreshToken: $refreshToken, tenantId: $tenantId, uid: $uid)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.displayName == displayName &&
        other.photoURL == photoURL &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.isAnonymous == isAnonymous &&
        other.phoneNumber == phoneNumber &&
        other.refreshToken == refreshToken &&
        other.tenantId == tenantId &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        photoURL.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        isAnonymous.hashCode ^
        phoneNumber.hashCode ^
        refreshToken.hashCode ^
        tenantId.hashCode ^
        uid.hashCode;
  }
}
