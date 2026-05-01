import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

const _kChartHeight = 180.0;
const _kDayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
const _kMinYPadding = 5.0;
const _kMaxYPadding = 10.0;

class WeightChart extends StatefulWidget {
  const WeightChart({super.key, required this.weeklyWeights});

  final List<double> weeklyWeights;

  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  late int _touchedIndex;

  @override
  void initState() {
    super.initState();
    _touchedIndex = _defaultIndex;
  }

  // ── Computed helpers ────────────────────────────────────────────────────────

  int get _defaultIndex => widget.weeklyWeights.isEmpty
      ? -1
      : widget.weeklyWeights.length - 1;

  double get _minY =>
      (widget.weeklyWeights.reduce(min) - _kMinYPadding).floorToDouble();

  double get _maxY =>
      (widget.weeklyWeights.reduce(max) + _kMaxYPadding).ceilToDouble();

  // ── Interaction ─────────────────────────────────────────────────────────────

  void _onBarTouch(FlTouchEvent event, BarTouchResponse? response) {
    final tapped = response?.spot?.touchedBarGroupIndex;
    setState(() {
      _touchedIndex =
          (event.isInterestedForInteractions && tapped != null)
              ? tapped
              : _defaultIndex;
    });
  }

  // ── Chart data builders ─────────────────────────────────────────────────────

  FlGridData get _gridData => FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (_) => FlLine(
          color: ColorsManager.lightGray.withValues(alpha: 0.3),
          strokeWidth: 1.w,
        ),
      );

  FlTitlesData _titlesData(int barCount) => FlTitlesData(
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: _buildDayLabel,
          ),
        ),
      );

  Widget _buildDayLabel(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= _kDayLabels.length) return const SizedBox.shrink();
    final isSelected = index == _touchedIndex;
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        _kDayLabels[index],
        style: isSelected
            ? AppTextStyles.font14SemiBoldPrimaryBlue.copyWith(fontSize: 12.sp)
            : AppTextStyles.font12RegularGray,
      ),
    );
  }

  BarTouchData get _touchData => BarTouchData(
        enabled: true,
        touchCallback: _onBarTouch,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 4,
          getTooltipItem: (_, _, rod, _) => BarTooltipItem(
            '${rod.toY}',
            AppTextStyles.font14SemiBoldPrimaryBlue,
          ),
        ),
      );

  BarChartGroupData _buildBarGroup(int index, double value, double barWidth) {
    final isSelected = index == _touchedIndex;
    return BarChartGroupData(
      x: index,
      showingTooltipIndicators: isSelected ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: value,
          color: isSelected ? ColorsManager.royalBlue : ColorsManager.grayishBlue,
          width: barWidth,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          ),
        ),
      ],
    );
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (widget.weeklyWeights.isEmpty) {
      return SizedBox(
        height: _kChartHeight.h,
        child: const Center(child: Text('No data available')),
      );
    }

    return SizedBox(
      height: _kChartHeight.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth / widget.weeklyWeights.length;
          return BarChart(
            duration: Duration.zero,
            BarChartData(
              alignment: BarChartAlignment.center,
              groupsSpace: 0,
              minY: _minY,
              maxY: _maxY,
              borderData: FlBorderData(show: false),
              gridData: _gridData,
              titlesData: _titlesData(widget.weeklyWeights.length),
              barTouchData: _touchData,
              barGroups: List.generate(
                widget.weeklyWeights.length,
                (i) => _buildBarGroup(i, widget.weeklyWeights[i], barWidth),
              ),
            ),
          );
        },
      ),
    );
  }
}
