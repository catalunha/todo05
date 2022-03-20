import 'dart:convert';

class UserModel {
  static const String collection = 'user';

  final String uuid;
  final String uidAuth;
  final String email;
  String? displayName;
  String? photoUrl;
  final bool doing;
  final String database;
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
    String? database,
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
      'database': database,
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
      database: map['database'],
      doing: map['doing'] ?? false,
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
    return 'UserModel(uuid: $uuid, uidAuth: $uidAuth, email: $email, displayName: $displayName, photoUrl: $photoUrl, database: $database, doing: $doing, createdAt: $createdAt, inAnalysis: $inAnalysis)';
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
        other.database == database &&
        other.doing == doing &&
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
        database.hashCode ^
        doing.hashCode ^
        createdAt.hashCode ^
        inAnalysis.hashCode;
  }
}
