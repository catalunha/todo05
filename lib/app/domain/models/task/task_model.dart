import 'dart:convert';

import 'package:uuid/uuid.dart';

class TaskModel {
  static const String collection = 'task';

  final String uuid;
  final String description;
  final DateTime date;
  final bool itsDone;
  final bool itsDoing;
  TaskModel({
    required this.uuid,
    required this.description,
    required this.date,
    required this.itsDone,
    required this.itsDoing,
  });

  TaskModel copyWith({
    String? uuid,
    String? description,
    DateTime? date,
    bool? itsDone,
    bool? itsDoing,
  }) {
    return TaskModel(
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
      date: date ?? this.date,
      itsDone: itsDone ?? this.itsDone,
      itsDoing: itsDoing ?? this.itsDoing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'description': description,
      'date': date,
      'itsDone': itsDone,
      'itsDoing': itsDoing,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      uuid: map['uuid'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(
          map['date'].millisecondsSinceEpoch),
      itsDone: map['itsDone'] ?? false,
      itsDoing: map['itsDoing'] ?? false,
    );
  }

  String toJson() {
    var map = toMap();
    map['date'] = date.toIso8601String();
    return json.encode(map);
  }

  factory TaskModel.fromJson(String source) {
    var map = json.decode(source);
    map['date'] = DateTime.tryParse(map['date'] as String) ?? DateTime.now();
    return TaskModel.fromMap(map);
  }
  @override
  String toString() {
    return 'TaskModel(uuid: $uuid, description: $description, date: $date, itsDone: $itsDone, itsDoing: $itsDoing)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.uuid == uuid &&
        other.description == description &&
        other.date == date &&
        other.itsDone == itsDone &&
        other.itsDoing == itsDoing;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        description.hashCode ^
        date.hashCode ^
        itsDone.hashCode ^
        itsDoing.hashCode;
  }
}
