import 'department.dart';
import 'program.dart';

/// How strongly a single-program department (Nursing / Criminology) fits.
enum FitLevel { strong, moderate, low }

extension FitLevelLabel on FitLevel {
  String get label {
    switch (this) {
      case FitLevel.strong:
        return 'Strong Fit';
      case FitLevel.moderate:
        return 'Moderate Fit';
      case FitLevel.low:
        return 'Low Fit';
    }
  }
}

/// A department's score and standing after Phase 1.
class DepartmentScore {
  const DepartmentScore({
    required this.department,
    required this.score,
    required this.rank,
  });

  final Department department;
  final int score;
  final int rank;
}

/// A program's score and standing within its department after Phase 2.
class ProgramScore {
  const ProgramScore({
    required this.program,
    required this.score,
    required this.rank,
  });

  final Program program;
  final int score;
  final int rank;
}

/// How a Top-3 recommendation was chosen.
enum RecommendationKind {
  /// Highest (or 2nd/3rd highest) scoring program within the top department.
  programRank,

  /// Flagship program pulled from the 2nd/3rd-ranked department as a fallback.
  flagshipFallback,

  /// The single program of a one-program department, measured by confirmation
  /// fit (Nursing / Criminology).
  confirmationFit,
}

/// One entry of the final Top 3 recommendation list.
class Recommendation {
  const Recommendation({
    required this.rank,
    required this.program,
    required this.basis,
    required this.points,
    required this.maxPoints,
    this.sourceDepartment,
    this.kind = RecommendationKind.programRank,
    this.fitLevel,
  });

  final int rank;
  final Program program;

  /// Human-readable explanation of why this program was recommended.
  final String basis;

  /// Raw points earned (Phase 2 program tally, confirmation score, or Phase 1
  /// department score for flagship fallbacks).
  final int points;
  final int maxPoints;

  /// The department this recommendation was pulled from (top department, or
  /// the 2nd/3rd-ranked department for flagship fallbacks).
  final Department? sourceDepartment;
  final RecommendationKind kind;
  final FitLevel? fitLevel;

  int get percentage => maxPoints <= 0 ? 0 : (points * 100 / maxPoints).round();
  String get scoreLabel => '$points / $maxPoints';
}

/// Complete result of a two-phase assessment.
class AssessmentOutcome {
  const AssessmentOutcome({
    required this.topDepartment,
    required this.departmentScores,
    required this.recommendations,
    this.programScores,
    this.confirmationScore,
    this.fitLevel,
  });

  final Department topDepartment;

  /// All 8 departments ranked by their Phase 1 score.
  final List<DepartmentScore> departmentScores;

  /// Program tallies within the top department (null for one-program
  /// departments).
  final List<ProgramScore>? programScores;

  /// Confirmation score out of 16 for Nursing / Criminology.
  final int? confirmationScore;

  /// Fit classification for single-program departments.
  final FitLevel? fitLevel;

  final List<Recommendation> recommendations;
}
