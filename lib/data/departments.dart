import '../models/department.dart';
import '../models/program.dart';

/// Canonical department list. Row order doubles as the tie-break order when
/// Phase 1 departments are tied on points (top-to-bottom as in the workbook).
const List<Department> departments = [
  Department(
    code: 'IT',
    name: 'School of Information Technology',
    description:
        'Digital solutions, software, data, and systems that power modern life.',
  ),
  Department(
    code: 'ENG',
    name: 'School of Engineering',
    description:
        'Designing and building structures, machines, and power systems.',
  ),
  Department(
    code: 'ED',
    name: 'School of Teacher Education',
    description:
        'Shaping and guiding the next generation inside the classroom.',
  ),
  Department(
    code: 'BUS',
    name: 'School of Business and Accountancy',
    description:
        'Growing businesses, managing finances, and leading organizations.',
  ),
  Department(
    code: 'HM',
    name: 'School of International Hospitality Management',
    description:
        'Creating memorable experiences for travelers and guests.',
  ),
  Department(
    code: 'HUM',
    name: 'School of Humanities',
    description:
        'Communication, media, and understanding human behavior.',
  ),
  Department(
    code: 'HS',
    name: 'School of Health and Sciences',
    description: 'Caring for the sick and saving lives in healthcare.',
  ),
  Department(
    code: 'CRIM',
    name: 'School of Criminology',
    description: 'Keeping communities safe and upholding justice.',
  ),
];

/// Master list of all 24 programs, grouped by department (row order matches
/// the workbook's `Programs` sheet and is the tie-break order for Phase 2).
const List<Program> programs = [
  // IT
  Program(
    code: 'IT1',
    name: 'BS Computer Science (Major in Data Science)',
    departmentCode: 'IT',
    isFlagship: true,
  ),
  Program(
    code: 'IT2',
    name: 'BS Information Technology (Major in Web Development)',
    departmentCode: 'IT',
  ),
  Program(
    code: 'IT3',
    name: 'BS Information Technology (Major in Multimedia Arts)',
    departmentCode: 'IT',
  ),
  Program(
    code: 'IT4',
    name: 'BS Information Technology (Major in Infrastructure w/ Cybersecurity)',
    departmentCode: 'IT',
  ),
  // Engineering
  Program(
    code: 'ENG1',
    name: 'BS Civil Engineering',
    departmentCode: 'ENG',
    isFlagship: true,
  ),
  Program(
    code: 'ENG2',
    name: 'BS Computer Engineering',
    departmentCode: 'ENG',
  ),
  Program(
    code: 'ENG3',
    name: 'BS Electrical Engineering',
    departmentCode: 'ENG',
  ),
  Program(
    code: 'ENG4',
    name: 'BS Electronics Engineering',
    departmentCode: 'ENG',
  ),
  // Teacher Education
  Program(
    code: 'ED1',
    name: 'Bachelor of Early Childhood Education',
    departmentCode: 'ED',
    isFlagship: true,
  ),
  Program(
    code: 'ED2',
    name: 'Bachelor of Elementary Education',
    departmentCode: 'ED',
  ),
  Program(
    code: 'ED3',
    name: 'Bachelor of Secondary Education (Major in English)',
    departmentCode: 'ED',
  ),
  Program(
    code: 'ED4',
    name: 'Bachelor of Secondary Education (Major in Filipino)',
    departmentCode: 'ED',
  ),
  Program(
    code: 'ED5',
    name: 'Bachelor of Secondary Education (Major in Mathematics)',
    departmentCode: 'ED',
  ),
  Program(
    code: 'ED6',
    name: 'Bachelor of Secondary Education (Major in Science)',
    departmentCode: 'ED',
  ),
  Program(
    code: 'ED7',
    name: 'Bachelor of Special Needs Education (Generalist)',
    departmentCode: 'ED',
  ),
  // Business & Accountancy
  Program(
    code: 'BUS1',
    name: 'BS Accountancy',
    departmentCode: 'BUS',
    isFlagship: true,
  ),
  Program(
    code: 'BUS2',
    name: 'BS Business Administration (Major in Financial Management)',
    departmentCode: 'BUS',
  ),
  Program(
    code: 'BUS3',
    name: 'BS Business Administration (Major in Marketing Management)',
    departmentCode: 'BUS',
  ),
  // International Hospitality Management
  Program(
    code: 'HM1',
    name: 'BS Hospitality Management',
    departmentCode: 'HM',
    isFlagship: true,
  ),
  Program(
    code: 'HM2',
    name: 'BS Tourism Management',
    departmentCode: 'HM',
  ),
  // Humanities
  Program(
    code: 'HUM1',
    name: 'BA Communication',
    departmentCode: 'HUM',
    isFlagship: true,
  ),
  Program(
    code: 'HUM2',
    name: 'BS Psychology',
    departmentCode: 'HUM',
  ),
  // Health & Sciences
  Program(
    code: 'HS1',
    name: 'BS Nursing',
    departmentCode: 'HS',
    isFlagship: true,
  ),
  // Criminology
  Program(
    code: 'CRIM1',
    name: 'BS Criminology',
    departmentCode: 'CRIM',
    isFlagship: true,
  ),
];

/// Programs of a department in workbook (canonical) order.
List<Program> programsForDepartment(String departmentCode) {
  return [
    for (final p in programs)
      if (p.departmentCode == departmentCode) p,
  ];
}

Program flagshipProgram(String departmentCode) {
  return programs.firstWhere(
    (p) => p.departmentCode == departmentCode && p.isFlagship,
  );
}
