import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:programfit/app.dart';
import 'package:programfit/data/assessment_questions.dart';
import 'package:programfit/models/assessment_outcome.dart';
import 'package:programfit/utils/recommendation_engine.dart';

void main() {
  group('Phase 1 department tally', () {
    test('demo walkthrough ranks IT first (6 pts) with ENG second (1 pt)', () {
      final selections = [0, 0, 0, 0, 0, 0, 1];
      final scores = tallyDepartments(selections);

      expect(scores.length, 8);
      expect(scores[0].department.code, 'IT');
      expect(scores[0].score, 6);
      expect(scores[0].rank, 1);
      expect(scores[1].department.code, 'ENG');
      expect(scores[1].score, 1);
      expect(scores[1].rank, 2);
      for (final score in scores.skip(2)) {
        expect(score.score, 0);
      }
    });

    test('ties are broken by canonical department order', () {
      final selections = [0, 0, 1, 1, 2, 3, 4];
      final scores = tallyDepartments(selections);

      expect(scores[0].department.code, 'IT');
      expect(scores[0].score, 2);
      expect(scores[1].department.code, 'ENG');
      expect(scores[1].score, 2);
      expect(scores[0].rank, 1);
      expect(scores[1].rank, 2);
      expect(
        scores.map((s) => s.department.code).toList(),
        ['IT', 'ENG', 'ED', 'BUS', 'HM', 'HUM', 'HS', 'CRIM'],
      );
    });
  });

  group('Phase 2 program tally', () {
    test('demo walkthrough scores IT programs IT1=5, IT2=1, IT3=1, IT4=1', () {
      final questions = phase2QuestionsByDepartment['IT']!;
      final selections = [0, 0, 0, 0, 0, 1, 2, 3];
      final scores = tallyPrograms('IT', selections, questions);

      expect(scores.length, 4);
      expect(scores.map((s) => s.program.code).toList(), ['IT1', 'IT2', 'IT3', 'IT4']);
      expect(scores.map((s) => s.score).toList(), [5, 1, 1, 1]);
      expect(scores.map((s) => s.rank).toList(), [1, 2, 3, 4]);
    });
  });

  group('buildOutcome top-3 recommendations', () {
    test('multi-program department returns its top 3 programs', () {
      final outcome = buildOutcome(
        phase1Selections: [0, 0, 0, 0, 0, 0, 1],
        phase2Selections: [0, 0, 0, 0, 0, 1, 2, 3],
      );

      expect(outcome.topDepartment.code, 'IT');
      expect(outcome.confirmationScore, isNull);
      expect(outcome.fitLevel, isNull);
      expect(outcome.recommendations, hasLength(3));
      expect(
        outcome.recommendations.map((r) => r.program.code).toList(),
        ['IT1', 'IT2', 'IT3'],
      );
      expect(outcome.recommendations.first.kind, RecommendationKind.programRank);
      expect(outcome.recommendations.first.points, 5);
      expect(outcome.recommendations.first.maxPoints, phase2QuestionCount);
      expect(outcome.recommendations.first.scoreLabel, '5 / 8');
    });

    test('Nursing uses confirmation scoring and falls back to flagships', () {
      final outcome = buildOutcome(
        phase1Selections: [6, 6, 6, 6, 6, 6, 6],
        phase2Selections: [2, 2, 2, 2, 2, 2, 2, 2],
      );

      expect(outcome.topDepartment.code, 'HS');
      expect(outcome.confirmationScore, 16);
      expect(outcome.fitLevel, FitLevel.strong);
      expect(outcome.recommendations, hasLength(3));
      expect(
        outcome.recommendations.map((r) => r.program.code).toList(),
        ['HS1', 'IT1', 'ENG1'],
      );
      expect(outcome.recommendations.first.kind, RecommendationKind.confirmationFit);
      expect(outcome.recommendations.first.scoreLabel, '16 / 16');
      expect(
        outcome.recommendations[1].kind,
        RecommendationKind.flagshipFallback,
      );
      expect(
        outcome.recommendations[2].kind,
        RecommendationKind.flagshipFallback,
      );
    });

    test('Criminology confidence score classifies moderate fit', () {
      final outcome = buildOutcome(
        phase1Selections: [7, 7, 7, 7, 7, 7, 7],
        phase2Selections: [2, 1, 2, 1, 2, 1, 1, 0],
      );

      expect(outcome.topDepartment.code, 'CRIM');
      expect(outcome.confirmationScore, 10);
      expect(outcome.fitLevel, FitLevel.moderate);
      expect(
        outcome.recommendations.map((r) => r.program.code).toList(),
        ['CRIM1', 'IT1', 'ENG1'],
      );
    });

    test('low confirmation score classifies low fit', () {
      final outcome = buildOutcome(
        phase1Selections: [6, 6, 6, 6, 6, 6, 6],
        phase2Selections: [0, 1, 0, 0, 1, 0, 1, 0],
      );

      expect(outcome.confirmationScore, 3);
      expect(outcome.fitLevel, FitLevel.low);
    });
  });

  group('confirmation scoring helpers', () {
    test('scoreConfirmation totals the point key', () {
      expect(scoreConfirmation([2, 2, 2, 2, 2, 2, 2, 2]), 16);
      expect(scoreConfirmation([1, 1, 1, 1, 1, 1, 1, 1]), 8);
      expect(scoreConfirmation([0, 0, 0, 0, 0, 0, 0, 0]), 0);
    });

    test('classifyFit matches the workbook thresholds', () {
      expect(classifyFit(16), FitLevel.strong);
      expect(classifyFit(12), FitLevel.strong);
      expect(classifyFit(11), FitLevel.moderate);
      expect(classifyFit(7), FitLevel.moderate);
      expect(classifyFit(6), FitLevel.low);
      expect(classifyFit(0), FitLevel.low);
    });
  });

  testWidgets('app launches directly into the home screen without auth',
      (tester) async {
    await tester.pumpWidget(const ProgramFitApp());

    expect(find.text('Welcome to ProgramFit'), findsOneWidget);
    expect(find.text('Start Assessment'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
