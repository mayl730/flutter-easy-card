import 'package:cloud_firestore/cloud_firestore.dart';

class CardModelWithId {
  final String id;
  final String colorTheme;
  final String company;
  final String creator;
  final String email;
  final String facebook;
  final String imageUrl;
  final bool isPrivate;
  final String jobTitle;
  final String linkedin;
  final String name;
  final String phone;
  final String twitter;
  final String website;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CardModelWithId({
    required this.id,
    required this.colorTheme,
    required this.company,
    required this.creator,
    required this.email,
    required this.facebook,
    required this.imageUrl,
    required this.isPrivate,
    required this.jobTitle,
    required this.linkedin,
    required this.name,
    required this.phone,
    required this.twitter,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardModelWithId.fromSnapshot(DocumentSnapshot snapshot) {
    return CardModelWithId(
      id: snapshot['id'] ?? '',
      colorTheme: snapshot['colorTheme'] ?? '',
      company: snapshot['company'] ?? '',
      creator: snapshot['creator'] ?? '',
      email: snapshot['email'] ?? '',
      facebook: snapshot['facebook'] ?? '',
      imageUrl: snapshot['imageUrl'] ?? '',
      isPrivate: snapshot['isPrivate'] ?? '',
      jobTitle: snapshot['jobTitle'] ?? '',
      linkedin: snapshot['linkedin'] ?? '',
      name: snapshot['name'] ?? '',
      phone: snapshot['phone'] ?? '',
      twitter: snapshot['twitter'] ?? '',
      website: snapshot['website'] ?? '',
      createdAt: snapshot['createdAt'] ?? '',
      updatedAt: snapshot['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'colorTheme': colorTheme,
      'company': company,
      'creator': creator,
      'email': email,
      'facebook': facebook,
      'imageUrl': imageUrl,
      'isPrivate': isPrivate,
      'jobTitle': jobTitle,
      'linkedin': linkedin,
      'name': name,
      'phone': phone,
      'twitter': twitter,
      'website': website,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  CardModelWithId copyWith({
    String? id,
    String? colorTheme,
    String? company,
    String? creator,
    String? email,
    String? facebook,
    String? imageUrl,
    bool? isPrivate,
    String? jobTitle,
    String? linkedin,
    String? name,
    String? phone,
    String? twitter,
    String? website,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return CardModelWithId(
      id: id ?? this.id,
      colorTheme: colorTheme ?? this.colorTheme,
      company: company ?? this.company,
      creator: creator ?? this.creator,
      email: email ?? this.email,
      facebook: facebook ?? this.facebook,
      imageUrl: imageUrl ?? this.imageUrl,
      isPrivate: isPrivate ?? this.isPrivate,
      jobTitle: jobTitle ?? this.jobTitle,
      linkedin: linkedin ?? this.linkedin,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      twitter: twitter ?? this.twitter,
      website: website ?? this.website,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
