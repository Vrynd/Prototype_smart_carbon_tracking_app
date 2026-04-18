import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/statistic/models/carbon_activity_point.dart';

class CarbonActivityChart extends StatefulWidget {
  final List<CarbonActivityPoint> points;
  final double blockSize;
  final double blockGap;
  final int rows;

  const CarbonActivityChart({
    super.key,
    required this.points,
    this.blockSize = 22,
    this.blockGap = 2,
    this.rows = 7,
  });

  @override
  State<CarbonActivityChart> createState() => _CarbonActivityChartState();
}

class _CarbonActivityChartState extends State<CarbonActivityChart> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalWeeks = (widget.points.length / widget.rows).ceil();

    return AppContainer(
      width: double.infinity,
      borderRadius: 16,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: (() {
                final List<Widget> labelWidgets = [];
                String? currentMonth;
                int weekCount = 0;

                void addLabel(String? month, int count) {
                  if (month == null) return;
                  labelWidgets.add(
                    Container(
                      width: count * (widget.blockSize + widget.blockGap),
                      height: 20,
                      alignment: Alignment.center,
                      child: Text(
                        month,
                        style: context.text.labelMedium?.copyWith(
                          color: context.colors.outlineVariant
                        ),
                      ),
                    ),
                  );
                }

                for (int i = 0; i < totalWeeks; i++) {
                  final int firstPointIndex = i * widget.rows;
                  if (firstPointIndex >= widget.points.length) break;
                  
                  final month = widget.points[firstPointIndex].description;
                  if (currentMonth == null) {
                    currentMonth = month;
                    weekCount = 1;
                  } else if (month == currentMonth) {
                    weekCount++;
                  } else {
                    addLabel(currentMonth, weekCount);
                    currentMonth = month;
                    weekCount = 1;
                  }
                }
                addLabel(currentMonth, weekCount);
                return labelWidgets;
              })(),
            ),
            AppSpacing.vGap8,
          
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(totalWeeks, (weekIndex) {
                return Padding(
                  padding: EdgeInsets.only(right: widget.blockGap),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.rows, (dayIndex) {
                      final int dataIndex = (weekIndex * widget.rows) + dayIndex;
                      final CarbonActivityPoint? point = 
                          dataIndex < widget.points.length ? widget.points[dataIndex] : null;
                      
                      return Padding(
                        padding: EdgeInsets.only(bottom: widget.blockGap),
                        child: _buildHeatmapBlock(context, point),
                      );
                    }),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeatmapBlock(BuildContext context, CarbonActivityPoint? point) {
    return Container(
      width: widget.blockSize,
      height: widget.blockSize,
      decoration: BoxDecoration(
        color: point?.color ?? context.colors.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
