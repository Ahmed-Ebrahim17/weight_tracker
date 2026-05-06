import 'package:weight_tracker/features/weight_tracking/domain/entities/target_goal_entity.dart';

class TargetGoalModel extends TargetGoalEntity {
  const TargetGoalModel({
    required super.targetWeight,
    required super.targetDate,
    required super.goalType,
  });

  factory TargetGoalModel.fromJson(Map<String, dynamic> json) {
    return TargetGoalModel(
      targetWeight: (json['targetWeight'] as num).toDouble(),
      targetDate: DateTime.parse(json['targetDate'] as String),
      goalType: json['goalType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetWeight': targetWeight,
      'targetDate': targetDate.toIso8601String(),
      'goalType': goalType,
    };
  }
}
