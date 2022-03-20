class TasksDayModel {
  final DateTime dateTime;
  final int quantityDone;
  final int quantityNotDone;
  TasksDayModel({
    required this.dateTime,
    required this.quantityDone,
    required this.quantityNotDone,
  });

  TasksDayModel copyWith({
    DateTime? dateTime,
    int? quantityDone,
    int? quantityNotDone,
  }) {
    return TasksDayModel(
      dateTime: dateTime ?? this.dateTime,
      quantityDone: quantityDone ?? this.quantityDone,
      quantityNotDone: quantityNotDone ?? this.quantityNotDone,
    );
  }
}
