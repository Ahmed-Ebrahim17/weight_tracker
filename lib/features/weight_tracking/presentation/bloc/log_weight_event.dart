part of 'log_weight_bloc.dart';

abstract class LogWeightEvent extends Equatable {
  const LogWeightEvent();

  @override
  List<Object?> get props => [];
}

/// Event when weight input changes
class WeightChanged extends LogWeightEvent {
  final String weight;
  const WeightChanged(this.weight);

  @override
  List<Object?> get props => [weight];
}

/// Event when date is selected
class DateSelected extends LogWeightEvent {
  final DateTime date;
  const DateSelected(this.date);

  @override
  List<Object?> get props => [date];
}

/// Event when time is selected
class TimeSelected extends LogWeightEvent {
  final TimeOfDay time;
  const TimeSelected(this.time);

  @override
  List<Object?> get props => [time];
}

/// Event when notes input changes
class NotesChanged extends LogWeightEvent {
  final String notes;
  const NotesChanged(this.notes);

  @override
  List<Object?> get props => [notes];
}

/// Event to save the weight entry
class SaveWeightEntry extends LogWeightEvent {
  const SaveWeightEntry();
}

/// Event to reset form
class ResetForm extends LogWeightEvent {
  const ResetForm();
}
