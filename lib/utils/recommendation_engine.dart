import '../data/assessment_questions.dart';
import '../data/departments.dart';
import '../models/assessment_outcome.dart';
import '../models/assessment_question.dart';

/// Phase 1 has 7 general questions.
const int phase1QuestionCount = 7;

/// Phase 2 always has 8 questions (department-specific or confirmation).
const int phase2QuestionCount = 8;

/// Confirmation point key max (Yes=2 x 8 questions = 16).
const int confirmationMaxScore = 16;

/// A program is a STRONG fit at >= 12 / 16, MODERATE at 7-11, LOW at 0-6.
const int strongFitThreshold = 12;
const int moderateFitThreshold = 7;

/// Mirrors the workbook's Phase-1 tally: each answer gives 1 point to its
/// mapped department. Ranks by score descending, breaking ties by canonical
/// department order (top-to-bottom in the department list).
List<DepartmentScore> tallyDepartments(List<int> phase1Selections) {
  final scores = <String, int>{for (final d in departments) d.code: 0};

  for (var i = 0; i < phase1Questions.length && i < phase1Selections.length; i++) {
    final selected = phase1Selections[i];
    if (selected < 0 || selected >= phase1Questions[i].options.length) continue;
    final target = phase1Questions[i].options[selected].targetCode;
    scores[target] = scores[target]! + 1;
  }

  final order = {
    for (var i = 0; i < departments.length; i++) departments[i].code: i,
  };
  final ranked = departments.toList()
    ..sort((a, b) {
      final byScore = scores[b.code]!.compareTo(scores[a.code]!);
      return byScore != 0 ? byScore : order[a.code]!.compareTo(order[b.code]!);
    });

  return [
    for (var i = 0; i < ranked.length; i++)
      DepartmentScore(
        department: ranked[i],
        score: scores[ranked[i].code]!,
        rank: i + 1,
      ),
  ];
}

/// Mirrors the workbook's Phase-2 tally within a department: each answer gives
/// 1 point to its mapped program. Ranks by score descending, breaking ties by
/// the department's program order (workbook row order).
List<ProgramScore> tallyPrograms(
  String departmentCode,
  List<int> phase2Selections,
  List<AssessmentQuestion> questions,
) {
  final deptPrograms = programsForDepartment(departmentCode);
  final scores = <String, int>{for (final p in deptPrograms) p.code: 0};

  for (var i = 0; i < questions.length && i < phase2Selections.length; i++) {
    final selected = phase2Selections[i];
    if (selected < 0 || selected >= questions[i].options.length) continue;
    final target = questions[i].options[selected].targetCode;
    if (scores.containsKey(target)) scores[target] = scores[target]! + 1;
  }

  final order = {
    for (var i = 0; i < deptPrograms.length; i++) deptPrograms[i].code: i,
  };
  final ranked = deptPrograms.toList()
    ..sort((a, b) {
      final byScore = scores[b.code]!.compareTo(scores[a.code]!);
      return byScore != 0 ? byScore : order[a.code]!.compareTo(order[b.code]!);
    });

  return [
    for (var i = 0; i < ranked.length; i++)
      ProgramScore(
        program: ranked[i],
        score: scores[ranked[i].code]!,
        rank: i + 1,
      ),
  ];
}

/// Confirmation scoring for single-program departments.
/// Answers are 0 = No, 1 = Somewhat, 2 = Yes.
int scoreConfirmation(List<int> answers) {
  var total = 0;
  for (final answer in answers) {
    if (answer > 0) total += answer;
  }
  return total;
}

FitLevel classifyFit(int score) {
  if (score >= strongFitThreshold) return FitLevel.strong;
  if (score >= moderateFitThreshold) return FitLevel.moderate;
  return FitLevel.low;
}

/// Builds the complete assessment outcome (tally -> rank -> recommend).
///
/// - Recommendation #1 is the top Phase-2 program in the top department (or
///   the single program with a confidence score for Nursing/Criminology).
/// - Recommendation #2 is the 2nd program of the same department, falling back
///   to the 2nd-ranked department's flagship program for one-program
///   departments.
/// - Recommendation #3 is the 3rd program of the same department, falling back
///   to the 3rd-ranked department's flagship program when there is no 3rd
///   option.
AssessmentOutcome buildOutcome({
  required List<int> phase1Selections,
  required List<int> phase2Selections,
}) {
  final departmentScores = tallyDepartments(phase1Selections);
  final top = departmentScores[0];
  final second = departmentScores[1];
  final third = departmentScores[2];

  final topPrograms = programsForDepartment(top.department.code);
  final isConfirmationDept =
      confirmationQuestionsByDepartment.containsKey(top.department.code);

  // Single-program department (Nursing / Criminology): measure fit instead of
  // ranking, then fall back to flagship programs for #2 and #3.
  if (isConfirmationDept || topPrograms.length == 1) {
    final confirmationScore = scoreConfirmation(phase2Selections);
    final fitLevel = classifyFit(confirmationScore);

    return AssessmentOutcome(
      topDepartment: top.department,
      departmentScores: departmentScores,
      confirmationScore: confirmationScore,
      fitLevel: fitLevel,
      recommendations: [
        Recommendation(
          rank: 1,
          program: topPrograms.single,
          basis:
              'Single-program department — confidence score from your confirmation answers',
          points: confirmationScore,
          maxPoints: confirmationMaxScore,
          kind: RecommendationKind.confirmationFit,
          fitLevel: fitLevel,
          sourceDepartment: top.department,
        ),
        _flagshipRecommendation(2, second),
        _flagshipRecommendation(3, third),
      ],
    );
  }

  final questions = phase2QuestionsByDepartment[top.department.code] ?? const [];
  final programScores = tallyPrograms(top.department.code, phase2Selections, questions);

  return AssessmentOutcome(
    topDepartment: top.department,
    departmentScores: departmentScores,
    programScores: programScores,
    recommendations: [
      Recommendation(
        rank: 1,
        program: programScores[0].program,
        basis: 'Highest-scoring program in your top department',
        points: programScores[0].score,
        maxPoints: phase2QuestionCount,
        sourceDepartment: top.department,
      ),
      if (programScores.length >= 2)
        Recommendation(
          rank: 2,
          program: programScores[1].program,
          basis: '2nd highest-scoring program in your top department',
          points: programScores[1].score,
          maxPoints: phase2QuestionCount,
          sourceDepartment: top.department,
        )
      else
        _flagshipRecommendation(2, second),
      if (programScores.length >= 3)
        Recommendation(
          rank: 3,
          program: programScores[2].program,
          basis: '3rd highest-scoring program in your top department',
          points: programScores[2].score,
          maxPoints: phase2QuestionCount,
          sourceDepartment: top.department,
        )
      else
        _flagshipRecommendation(3, third),
    ],
  );
}

Recommendation _flagshipRecommendation(int rank, DepartmentScore departmentScore) {
  return Recommendation(
    rank: rank,
    program: flagshipProgram(departmentScore.department.code),
    basis:
        'Flagship program of your ${_ordinal(rank)}-ranked department',
    points: departmentScore.score,
    maxPoints: phase1QuestionCount,
    kind: RecommendationKind.flagshipFallback,
    sourceDepartment: departmentScore.department,
  );
}

String _ordinal(int n) {
  switch (n) {
    case 1:
      return '1st';
    case 2:
      return '2nd';
    case 3:
      return '3rd';
    default:
      return '$n';
  }
}
