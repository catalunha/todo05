import 'dart:convert';

import 'package:todo05/app/data/datasources/datasources.dart';

class UserModel {
  static const String collection = 'user';

  final String uuid;
  final String uidAuth;
  final String email;
  String? displayName;
  String? photoUrl;
  final bool doing;
  final DatasourcesEnum database;
  final DateTime createdAt;
  final bool inAnalysis;
  UserModel({
    required this.uuid,
    required this.uidAuth,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.doing,
    required this.database,
    required this.createdAt,
    required this.inAnalysis,
  });

  UserModel copyWith({
    String? uuid,
    String? uidAuth,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? doing,
    DatasourcesEnum? database,
    DateTime? createdAt,
    bool? inAnalysis,
  }) {
    return UserModel(
      uuid: uuid ?? this.uuid,
      uidAuth: uidAuth ?? this.uidAuth,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      doing: doing ?? this.doing,
      database: database ?? this.database,
      createdAt: createdAt ?? this.createdAt,
      inAnalysis: inAnalysis ?? this.inAnalysis,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'uidAuth': uidAuth,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'doing': doing,
      'database': database.name,
      'createdAt': createdAt,
      'inAnalysis': inAnalysis,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] ?? '',
      uidAuth: map['uidAuth'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      doing: map['doing'] ?? false,
      database: DatasourcesEnum.values.byName(map['database']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['createdAt'].millisecondsSinceEpoch),
      inAnalysis: map['inAnalysis'] ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source));
  String toJson() {
    var map = toMap();
    map['createdAt'] = createdAt.toIso8601String();
    return json.encode(map);
  }

  factory UserModel.fromJson(String source) {
    var map = json.decode(source);
    map['createdAt'] =
        DateTime.tryParse(map['createdAt'] as String) ?? DateTime.now();
    return UserModel.fromMap(map);
  }
  @override
  String toString() {
    return 'UserModel(uuid: $uuid, uidAuth: $uidAuth, email: $email, displayName: $displayName, photoUrl: $photoUrl, doing: $doing, database: $database, createdAt: $createdAt, inAnalysis: $inAnalysis)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uuid == uuid &&
        other.uidAuth == uidAuth &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl &&
        other.doing == doing &&
        other.database == database &&
        other.createdAt == createdAt &&
        other.inAnalysis == inAnalysis;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        uidAuth.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode ^
        doing.hashCode ^
        database.hashCode ^
        createdAt.hashCode ^
        inAnalysis.hashCode;
  }
}
