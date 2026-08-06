import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/assessment_outcome.dart';
import '../utils/recommendation_engine.dart';

/// Immutable snapshot of in-progress assessment answers.
typedef AssessmentProgress = ({
  int phase,
  int currentQuestion,
  List<int> phase1Answers,
  List<int> phase2Answers,
});

/// Local (SharedPreferences) persistence for the two-phase assessment.
///
/// Offline MVP: no accounts, no backend. The final outcome is derived from the
/// saved answers by [buildOutcome], so only the raw selections are stored.
class AssessmentService {
  AssessmentService._();

  static const String progressKey = 'pf_progress';
  static const String resultsKey = 'pf_results';

  static Future<void> saveProgress(AssessmentProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      progressKey,
      jsonEncode({
        'phase': progress.phase,
        'currentQuestion': progress.currentQuestion,
        'phase1Answers': progress.phase1Answers,
        'phase2Answers': progress.phase2Answers,
      }),
    );
  }

  static Future<AssessmentProgress?> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(progressKey);
    if (raw == null) return null;

    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final phase1 = _toIntList(data['phase1Answers']);
      final phase2 = _toIntList(data['phase2Answers']);
      if (phase1.length != phase1QuestionCount ||
          phase2.length != phase2QuestionCount) {
        return null;
      }
      return (
        phase: (data['phase'] as num?)?.toInt() ?? 1,
        currentQuestion: (data['currentQuestion'] as num?)?.toInt() ?? 0,
        phase1Answers: phase1,
        phase2Answers: phase2,
      );
    } catch (_) {
      return null;
    }
  }

  /// Whether every question in both phases has been answered.
  static Future<bool> isAssessmentComplete() async {
    final progress = await loadProgress();
    if (progress == null) return false;
    return progress.phase1Answers.every((a) => a >= 0) &&
        progress.phase2Answers.every((a) => a >= 0);
  }

  /// Recomputes the full outcome from the persisted answers, or null when the
  /// assessment is not yet complete.
  static Future<AssessmentOutcome?> loadOutcome() async {
    final progress = await loadProgress();
    if (progress == null) return null;
    if (progress.phase1Answers.any((a) => a < 0) ||
        progress.phase2Answers.any((a) => a < 0)) {
      return null;
    }
    return buildOutcome(
      phase1Selections: progress.phase1Answers,
      phase2Selections: progress.phase2Answers,
    );
  }

  /// Clears the saved assessment so it can be retaken.
  static Future<void> resetAssessment() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(progressKey);
    await prefs.remove(resultsKey);
  }

  static List<int> _toIntList(dynamic value) {
    if (value is! List) return const [];
    return value.map((e) => (e as num?)?.toInt() ?? -1).toList();
  }
}
