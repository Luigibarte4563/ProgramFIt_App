/// A Yes / Somewhat / No confirmation question used by single-program
/// departments (Nursing and Criminology) to measure fit strength.
class ConfirmationQuestion {
  const ConfirmationQuestion({
    required this.id,
    required this.question,
    required this.programCode,
  });

  final int id;
  final String question;
  final String programCode;
}
