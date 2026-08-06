import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../core/widgets/neo_badge.dart';
import '../core/widgets/neo_button.dart';
import '../core/widgets/neo_card.dart';
import '../data/assessment_questions.dart';
import '../models/assessment_question.dart';
import '../models/confirmation_question.dart';
import '../models/department.dart';
import '../services/assessment_service.dart';
import '../utils/recommendation_engine.dart';
import 'widgets/confirmation_card.dart';
import 'widgets/progress_bar.dart';
import 'widgets/question_card.dart';

/// Two-phase questionnaire engine:
///
/// Phase 1 — 7 general questions map the student to a top department.
/// Phase 2 — 8 department-specific questions rank that department's programs
/// (or 8 confirmation questions measure fit for Nursing / Criminology).
class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  late List<int> _phase1Answers;
  late List<int> _phase2Answers;
  int _phase = 1;
  int _currentIndex = 0;
  bool _showIntro = false;
  bool _loaded = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _phase1Answers = List.filled(phase1QuestionCount, -1);
    _phase2Answers = List.filled(phase2QuestionCount, -1);
    _loadProgress();
  }

  // ---------------------------------------------------------------------------
  // Derived state
  // ---------------------------------------------------------------------------

  bool get _phase1Complete => _phase1Answers.every((a) => a >= 0);
  bool get _phase2Complete => _phase2Answers.every((a) => a >= 0);

  List<int> get _activeAnswers => _phase == 1 ? _phase1Answers : _phase2Answers;

  Department? get _topDepartment =>
      _phase1Complete ? tallyDepartments(_phase1Answers).first.department : null;

  bool get _isConfirmationDept =>
      _topDepartment != null &&
      confirmationQuestionsByDepartment.containsKey(_topDepartment!.code);

  List<AssessmentQuestion> get _phase2Questions {
    final dept = _topDepartment;
    if (dept == null) return const [];
    return phase2QuestionsByDepartment[dept.code] ?? const [];
  }

  List<ConfirmationQuestion> get _confirmationQuestions {
    final dept = _topDepartment;
    if (dept == null) return const [];
    return confirmationQuestionsByDepartment[dept.code] ?? const [];
  }

  int get _activeQuestionCount {
    if (_phase == 1) return phase1QuestionCount;
    return _isConfirmationDept
        ? _confirmationQuestions.length
        : phase2QuestionCount;
  }

  String get _phaseBadge => _phase == 1 ? 'Phase 1' : _topDepartment!.name;

  bool get _isFirstStep => !_showIntro && _phase == 1 && _currentIndex == 0;

  bool get _isLastQuestion => _currentIndex == _activeQuestionCount - 1;

  bool get _canAdvance => _phase == 1 ? _phase1Complete : _phase2Complete;

  // ---------------------------------------------------------------------------
  // Persistence
  // ---------------------------------------------------------------------------

  Future<void> _loadProgress() async {
    final progress = await AssessmentService.loadProgress();
    if (!mounted) return;

    setState(() {
      if (progress != null) {
        _phase1Answers = List.from(progress.phase1Answers);
        _phase2Answers = List.from(progress.phase2Answers);
        _phase = progress.phase;
        if (_phase == 2 && _phase1Complete) {
          _currentIndex =
              progress.currentQuestion.clamp(0, _activeQuestionCount - 1);
        } else {
          _phase = 1;
          _currentIndex =
              progress.currentQuestion.clamp(0, phase1QuestionCount - 1);
        }
      }
      _loaded = true;
    });
  }

  Future<void> _save() async {
    if (!_loaded) return;
    await AssessmentService.saveProgress((
      phase: _phase,
      currentQuestion: _currentIndex,
      phase1Answers: _phase1Answers,
      phase2Answers: _phase2Answers,
    ));
  }

  // ---------------------------------------------------------------------------
  // Handlers
  // ---------------------------------------------------------------------------

  void _handleAnswer(int value) {
    setState(() {
      if (_phase == 1) {
        _phase1Answers[_currentIndex] = value;
      } else {
        _phase2Answers[_currentIndex] = value;
      }
    });
    _save();
  }

  void _handleNext() {
    if (_showIntro) {
      setState(() => _showIntro = false);
      _save();
      return;
    }
    if (_phase == 1) {
      if (_currentIndex < phase1QuestionCount - 1) {
        setState(() => _currentIndex++);
        _save();
      } else if (_phase1Complete) {
        _advanceToPhase2();
      }
    } else if (_currentIndex < _activeQuestionCount - 1) {
      setState(() => _currentIndex++);
      _save();
    }
  }

  void _advanceToPhase2() {
    setState(() {
      _phase = 2;
      _currentIndex = 0;
      _showIntro = true;
    });
    _save();
  }

  void _handleBack() {
    if (_showIntro) {
      setState(() {
        _showIntro = false;
        _phase = 1;
        _currentIndex = phase1QuestionCount - 1;
      });
      _save();
    } else if (_phase == 2) {
      setState(() {
        if (_currentIndex > 0) {
          _currentIndex--;
        } else {
          _showIntro = true;
        }
      });
      _save();
    } else if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _save();
    }
  }

  void _handleSelectQuestion(int index) {
    setState(() => _currentIndex = index);
    _save();
  }

  Future<void> _handleFinish() async {
    if (!_phase2Complete || _busy) return;
    setState(() => _busy = true);
    try {
      await _save();
      if (mounted) context.go('/results');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 896),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 64),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProgressCard(),
                const SizedBox(height: 28),
                _buildQuestionArea(),
                const SizedBox(height: 28),
                _buildNavigation(),
                if (_isLastQuestion && !_canAdvance && !_showIntro)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _CompletionWarning(
                      message: _phase == 1
                          ? 'Please answer all 7 questions before continuing '
                              'to Phase 2.'
                          : 'Please answer all 8 questions before finishing '
                              'the assessment.',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    final answeredCount = _activeAnswers.where((a) => a >= 0).length;
    return NeoCard(
      shadowX: 6,
      shadowY: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Assessment Progress',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              NeoBadge(label: _phase == 1 ? 'Phase 1' : 'Phase 2'),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 2, color: AppColors.bgMain),
          const SizedBox(height: 16),
          ProgressBar(
            current: _currentIndex + 1,
            answered: answeredCount,
            total: _activeQuestionCount,
            answers: _activeAnswers,
            onSelectQuestion: _handleSelectQuestion,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionArea() {
    if (_showIntro) return _buildPhaseIntro();

    if (_phase == 1) {
      return QuestionCard(
        displayIndex: _currentIndex + 1,
        badge: _phaseBadge,
        question: phase1Questions[_currentIndex],
        selectedIndex: _phase1Answers[_currentIndex],
        onSelect: _handleAnswer,
      );
    }

    if (_isConfirmationDept) {
      return ConfirmationCard(
        displayIndex: _currentIndex + 1,
        question: _confirmationQuestions[_currentIndex],
        value: _phase2Answers[_currentIndex],
        onSelect: _handleAnswer,
      );
    }

    return QuestionCard(
      displayIndex: _currentIndex + 1,
      badge: _phaseBadge,
      question: _phase2Questions[_currentIndex],
      selectedIndex: _phase2Answers[_currentIndex],
      onSelect: _handleAnswer,
    );
  }

  Widget _buildPhaseIntro() {
    final dept = _topDepartment;
    if (dept == null) return const SizedBox.shrink();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 768),
        child: NeoCard(
          shadowX: 8,
          shadowY: 8,
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const NeoBadge(label: 'Phase 2'),
              const SizedBox(height: 16),
              const Text(
                'Your Top Department',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dept.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.brandPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                dept.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Container(height: 2, color: AppColors.bgMain),
              const SizedBox(height: 16),
              Text(
                _isConfirmationDept
                    ? 'Answer 8 short confirmation questions to measure how '
                        'strong a fit this program is for you.'
                    : 'Answer 8 questions about this department so we can rank '
                        'its programs for you.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    if (_showIntro) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NeoButton(
            label: 'Back',
            variant: NeoButtonVariant.white,
            onPressed: _handleBack,
          ),
          NeoButton(label: 'Continue', onPressed: _handleNext),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NeoButton(
          label: 'Back',
          variant: NeoButtonVariant.white,
          onPressed: _isFirstStep ? null : _handleBack,
        ),
        if (!_isLastQuestion)
          NeoButton(label: 'Next Question', onPressed: _handleNext)
        else if (_phase == 1)
          NeoButton(
            label: 'Continue to Phase 2',
            onPressed: _canAdvance ? _handleNext : null,
          )
        else
          NeoButton(
            label: 'Finish Assessment',
            variant: NeoButtonVariant.success,
            onPressed: _canAdvance && !_busy ? _handleFinish : null,
          ),
      ],
    );
  }
}

/// Alert shown on the final question of a phase when not everything is
/// answered.
class _CompletionWarning extends StatelessWidget {
  const _CompletionWarning({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 448),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.danger, width: 2),
            boxShadow: neoShadow(x: 4, y: 4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.danger,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFB91C1C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
