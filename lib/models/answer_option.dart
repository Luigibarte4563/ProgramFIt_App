/// A single selectable option within an assessment question.
///
/// [targetCode] is the code of whatever this option scores 1 point toward:
/// a department code in Phase 1, or a program code in Phase 2.
class AnswerOption {
  const AnswerOption({
    required this.text,
    required this.targetCode,
  });

  final String text;
  final String targetCode;
}
