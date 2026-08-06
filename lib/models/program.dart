class Program {
  const Program({
    required this.code,
    required this.name,
    required this.departmentCode,
    this.isFlagship = false,
  });

  final String code;
  final String name;
  final String departmentCode;

  /// Flagship programs are used as fallback recommendations when a department
  /// has fewer programs than needed for the Top 3.
  final bool isFlagship;
}
