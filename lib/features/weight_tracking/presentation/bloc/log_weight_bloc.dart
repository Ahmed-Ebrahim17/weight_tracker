import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker/core/database/services/weight_entry_service.dart';

part 'log_weight_event.dart';
part 'log_weight_state.dart';

class LogWeightBloc extends Bloc<LogWeightEvent, LogWeightState> {
  final WeightEntryService _weightEntryService;

  LogWeightBloc(this._weightEntryService) : super(LogWeightState()) {
    on<WeightChanged>(_onWeightChanged);
    on<DateSelected>(_onDateSelected);
    on<TimeSelected>(_onTimeSelected);
    on<NotesChanged>(_onNotesChanged);
    on<SaveWeightEntry>(_onSaveWeightEntry);
    on<ResetForm>(_onResetForm);
  }

  /// Handle weight input change
  Future<void> _onWeightChanged(
    WeightChanged event,
    Emitter<LogWeightState> emit,
  ) async {
    emit(state.copyWith(
      weight: event.weight,
      errorMessage: null, // Clear error when user starts typing
    ));
  }

  /// Handle date selection
  Future<void> _onDateSelected(
    DateSelected event,
    Emitter<LogWeightState> emit,
  ) async {
    emit(state.copyWith(selectedDate: event.date));
  }

  /// Handle time selection
  Future<void> _onTimeSelected(
    TimeSelected event,
    Emitter<LogWeightState> emit,
  ) async {
    emit(state.copyWith(selectedTime: event.time));
  }

  /// Handle notes input change
  Future<void> _onNotesChanged(
    NotesChanged event,
    Emitter<LogWeightState> emit,
  ) async {
    emit(state.copyWith(notes: event.notes));
  }

  /// Handle save weight entry
  Future<void> _onSaveWeightEntry(
    SaveWeightEntry event,
    Emitter<LogWeightState> emit,
  ) async {
    // Validate form
    if (!state.isFormValid) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid weight',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final weight = double.parse(state.weight);
      
      await _weightEntryService.addWeightEntry(
        weight: weight,
        date: state.selectedDate,
        time: DateTime(
          0, 0, 0,
          state.selectedTime.hour,
          state.selectedTime.minute,
        ),
        notes: state.notes.isEmpty ? null : state.notes,
      );

      // Success - reset form and show success message
      emit(LogWeightState(isSuccess: true));
      
      // Reset after a short delay
      await Future.delayed(const Duration(seconds: 1));
      emit(LogWeightState());
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to save entry: ${e.toString()}',
      ));
    }
  }

  /// Handle form reset
  Future<void> _onResetForm(
    ResetForm event,
    Emitter<LogWeightState> emit,
  ) async {
    emit(LogWeightState());
  }
}
