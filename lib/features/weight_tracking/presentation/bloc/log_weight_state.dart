part of 'log_weight_bloc.dart';

class LogWeightState extends Equatable {
  final String weight;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String notes;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  LogWeightState({
    this.weight = '',
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    this.notes = '',
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  })  : selectedDate = selectedDate ?? DateTime.now(),
        selectedTime = selectedTime ?? TimeOfDay.now();

  LogWeightState copyWith({
    String? weight,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? notes,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LogWeightState(
      weight: weight ?? this.weight,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  /// Check if form is valid
  bool get isFormValid {
    return weight.isNotEmpty && double.tryParse(weight) != null;
  }

  /// Get combined DateTime
  DateTime get combinedDateTime => DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );

  @override
  List<Object?> get props => [
    weight,
    selectedDate,
    selectedTime,
    notes,
    isLoading,
    errorMessage,
    isSuccess,
  ];
}
