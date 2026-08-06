import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/answer_option.dart';

/// Vertical list of selectable lettered options (A, B, C, ...).
///
/// Used for both Phase 1 (options map to departments) and Phase 2 (options map
/// to programs).
class OptionScale extends StatelessWidget {
  const OptionScale({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<AnswerOption> options;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  String _letter(int index) => String.fromCharCode(65 + index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          _OptionTile(
            letter: _letter(i),
            text: options[i].text,
            selected: selectedIndex == i,
            onTap: () => onSelect(i),
          ),
        ],
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.letter,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.brandPrimary : AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.shadowHard : AppColors.borderUi,
              width: 2,
            ),
            boxShadow: neoShadow(x: 2, y: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? AppColors.bgCard : AppColors.bgMain,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? AppColors.shadowHard : AppColors.borderUi,
                    width: 2,
                  ),
                ),
                child: Text(
                  letter,
                  style: TextStyle(
                    color:
                        selected ? AppColors.brandPrimary : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: selected ? Colors.white : AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
