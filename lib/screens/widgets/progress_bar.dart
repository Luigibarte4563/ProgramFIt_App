import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Assessment progress tracker, migrated from `ProgressBar.tsx`.
///
/// Shows "Question X of Y", an animated fill bar with the percentage, and a
/// navigable row of question-number buttons that auto-centers on the active
/// question.
class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
    required this.current,
    required this.answered,
    required this.total,
    required this.answers,
    required this.onSelectQuestion,
  });

  final int current;
  final int answered;
  final int total;
  final List<int> answers;
  final ValueChanged<int> onSelectQuestion;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late List<GlobalKey> _buttonKeys;
  late int _lastCurrent;
  bool _horizontalScrollActive = false;

  @override
  void initState() {
    super.initState();
    _buttonKeys = List.generate(widget.total, (_) => GlobalKey());
    _lastCurrent = widget.current;
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.total != oldWidget.total) {
      _buttonKeys = List.generate(widget.total, (_) => GlobalKey());
    }

    if (widget.current != _lastCurrent) {
      _lastCurrent = widget.current;
      _centerActiveQuestion();
    }
  }

  void _centerActiveQuestion() {
    if (!_horizontalScrollActive) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = widget.current - 1;
      if (index < 0 || index >= _buttonKeys.length) return;
      final ctx = _buttonKeys[index].currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        alignment: 0.5,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.answered / widget.total * 100;
    final isWide = MediaQuery.sizeOf(context).width >= 768;
    _horizontalScrollActive = !isWide;

    final left = _buildStatusColumn(percentage);
    final right = isWide
        ? _buildWrappedNavigator()
        : _buildScrollableNavigator();

    final content = isWide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: left),
              const SizedBox(width: 24),
              right,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              left,
              const SizedBox(height: 16),
              right,
            ],
          );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.shadowHard, width: 2),
        boxShadow: neoShadow(x: 4, y: 4),
      ),
      child: content,
    );
  }

  Widget _buildStatusColumn(double percentage) {
    final showWhiteText = percentage > 52;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text(
              'Question ',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            Text(
              '${widget.current}',
              style: const TextStyle(
                color: AppColors.brandPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            Text(
              ' of ${widget.total}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.shadowHard, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                FractionallySizedBox(
                  widthFactor: percentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary,
                      border: const Border(
                        right: BorderSide(color: AppColors.shadowHard, width: 2),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '${percentage.round()}%',
                      style: TextStyle(
                        color: showWhiteText
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableNavigator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < widget.total; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            _QuestionNumber(
              key: _buttonKeys[i],
              number: i + 1,
              isCurrent: i + 1 == widget.current,
              isAnswered: widget.answers[i] >= 0,
              onTap: () => widget.onSelectQuestion(i),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWrappedNavigator() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < widget.total; i++)
          _QuestionNumber(
            key: _buttonKeys[i],
            number: i + 1,
            isCurrent: i + 1 == widget.current,
            isAnswered: widget.answers[i] >= 0,
            onTap: () => widget.onSelectQuestion(i),
          ),
      ],
    );
  }
}

class _QuestionNumber extends StatelessWidget {
  const _QuestionNumber({
    super.key,
    required this.number,
    required this.isCurrent,
    required this.isAnswered,
    required this.onTap,
  });

  final int number;
  final bool isCurrent;
  final bool isAnswered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    final double shadow;

    if (isCurrent) {
      background = AppColors.brandPrimary;
      foreground = Colors.white;
      shadow = 2;
    } else if (isAnswered) {
      background = AppColors.bgMain;
      foreground = AppColors.textSecondary;
      shadow = 3;
    } else {
      background = AppColors.bgCard;
      foreground = AppColors.textSecondary;
      shadow = 3;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.shadowHard, width: 2),
            boxShadow: neoShadow(x: shadow, y: shadow),
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: foreground,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
