import 'answer_option.dart';

/// A single-choice question whose options map 1:1 to departments (Phase 1)
/// or to programs (Phase 2).
class AssessmentQuestion {
  const AssessmentQuestion({
    required this.id,
    required this.question,
    required this.options,
  });

  final int id;
  final String question;
  final List<AnswerOption> options;
}
