import 'package:flutter/material.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/entry_edit_screen_body.dart';

class EntryEditScreen extends StatefulWidget {
  final WeightEntryEntity entry;
  const EntryEditScreen({super.key, required this.entry});

  @override
  State<EntryEditScreen> createState() => _EntryEditScreenState();
}

class _EntryEditScreenState extends State<EntryEditScreen> {
  late TextEditingController _weightController;
  late TextEditingController _notesController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(
      text: widget.entry.weight.toStringAsFixed(1),
    );
    _notesController = TextEditingController(text: widget.entry.notes);
    _selectedDate = widget.entry.date;
    _selectedTime = TimeOfDay.fromDateTime(widget.entry.time);
    _dateController = TextEditingController(text: _formatDate(_selectedDate));
    _timeController = TextEditingController(text: _formatTime(_selectedTime));
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  void dispose() {
    _weightController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _formatTime(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsManager.nearBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.editEntry,
          style: AppTextStyles.font20BoldVeryDarkGray.copyWith(
            color: ColorsManager.primaryBlue,
          ),
        ),
        centerTitle: true,
      ),
      body: EntryEditScreenBody(
        weightController: _weightController,
        notesController: _notesController,
        dateController: _dateController,
        timeController: _timeController,
        selectedDate: _selectedDate,
        selectedTime: _selectedTime,
        onDateTap: _pickDate,
        onTimeTap: _pickTime,
        entry: widget.entry,
      ),
    );
  }
}
