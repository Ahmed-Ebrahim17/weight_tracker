class TargetGoalEntity {
  final double targetWeight;
  final DateTime targetDate;
  final String goalType;
  final double? startingWeight;

  const TargetGoalEntity({
    required this.targetWeight,
    required this.targetDate,
    required this.goalType,
    required this.startingWeight,
  });
}
