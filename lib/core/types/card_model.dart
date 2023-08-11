import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
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

  CardModel({
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
  });

  factory CardModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CardModel(
      colorTheme: snapshot['colorTheme'],
      company: snapshot['company'],
      creator: snapshot['creator'],
      email: snapshot['email'],
      facebook: snapshot['facebook'],
      imageUrl: snapshot['imageUrl'],
      isPrivate: snapshot['isPrivate'],
      jobTitle: snapshot['jobTitle'],
      linkedin: snapshot['linkedin'],
      name: snapshot['name'],
      phone: snapshot['phone'],
      twitter: snapshot['twitter'],
      website: snapshot['website'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
    };
  }
}
