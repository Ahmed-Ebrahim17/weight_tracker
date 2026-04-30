import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracker/core/database/services/weight_entry_service.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/dashboard_screen.dart';
import '../bloc/log_weight_bloc.dart';

class LogWeightScreen extends StatelessWidget {
  const LogWeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogWeightBloc(GetIt.instance<WeightEntryService>()),
      child: const LogWeightView(),
    );
  }
}

class LogWeightView extends StatefulWidget {
  const LogWeightView({super.key});

  @override
  State<LogWeightView> createState() => _LogWeightViewState();
}

class _LogWeightViewState extends State<LogWeightView> {
  late TextEditingController _weightController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Weight'),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<LogWeightBloc, LogWeightState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Weight entry saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            _weightController.clear();
            _notesController.clear();
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              // Weight Input Card
              _buildWeightInputCard(context),
              SizedBox(height: 24.h),

              // Date Card
              _buildDateCard(context),
              SizedBox(height: 16.h),

              // Time Card
              _buildTimeCard(context),
              SizedBox(height: 16.h),

              // Notes Card
              _buildNotesCard(context),
              SizedBox(height: 32.h),

              // Save Button
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightInputCard(BuildContext context) {
    return BlocBuilder<LogWeightBloc, LogWeightState>(
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Text(
                  'Current Weight',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    context.read<LogWeightBloc>().add(WeightChanged(value));
                  },
                  decoration: InputDecoration(
                    hintText: '0.0',
                    suffixText: 'lbs',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                if (state.errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateCard(BuildContext context) {
    return BlocBuilder<LogWeightBloc, LogWeightState>(
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _formatDate(state.selectedDate),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeCard(BuildContext context) {
    return BlocBuilder<LogWeightBloc, LogWeightState>(
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: InkWell(
              onTap: () => _selectTime(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.selectedTime.format(context),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.access_time,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes (Optional)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _notesController,
              onChanged: (value) {
                context.read<LogWeightBloc>().add(NotesChanged(value));
              },
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add any notes about this measurement...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocBuilder<LogWeightBloc, LogWeightState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    context.read<LogWeightBloc>().add(const SaveWeightEntry());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                  },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: state.isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'SAVE ENTRY',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final state = context.read<LogWeightBloc>().state;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: state.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      if (!mounted) return;
      context.read<LogWeightBloc>().add(DateSelected(pickedDate));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final state = context.read<LogWeightBloc>().state;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: state.selectedTime,
    );

    if (pickedTime != null) {
      if (!mounted) return;
      context.read<LogWeightBloc>().add(TimeSelected(pickedTime));
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
