import '../models/answer_option.dart';
import '../models/assessment_question.dart';
import '../models/confirmation_question.dart';

/// PHASE 1 — General questionnaire (7 questions, 8 lettered options A-H).
///
/// Each option scores 1 point toward its mapped department
/// (A=IT, B=Engineering, C=Teacher Education, D=Business & Accountancy,
/// E=Hospitality Management, F=Humanities, G=Health & Sciences,
/// H=Criminology).
const List<AssessmentQuestion> phase1Questions = [
  AssessmentQuestion(
    id: 1,
    question: 'Which activity sounds most fun to you?',
    options: [
      AnswerOption(
        text: 'Making something interactive work on a screen, step by step',
        targetCode: 'IT',
      ),
      AnswerOption(
        text: 'Building, fixing, or assembling something mechanical/structural',
        targetCode: 'ENG',
      ),
      AnswerOption(
        text: 'Tutoring or explaining a lesson to a friend',
        targetCode: 'ED',
      ),
      AnswerOption(
        text: 'Managing a budget or planning a small business',
        targetCode: 'BUS',
      ),
      AnswerOption(
        text: 'Planning an event, trip, or hosting guests',
        targetCode: 'HM',
      ),
      AnswerOption(
        text: 'Writing a story, making content, or analyzing behavior',
        targetCode: 'HUM',
      ),
      AnswerOption(
        text: 'Helping someone who is sick or injured',
        targetCode: 'HS',
      ),
      AnswerOption(
        text: 'Investigating a mystery or solving a case',
        targetCode: 'CRIM',
      ),
    ],
  ),
  AssessmentQuestion(
    id: 2,
    question: 'Which subject did you enjoy most in school?',
    options: [
      AnswerOption(text: 'Computer / ICT', targetCode: 'IT'),
      AnswerOption(text: 'Math and Physics', targetCode: 'ENG'),
      AnswerOption(
        text: 'Any subject you liked explaining to classmates',
        targetCode: 'ED',
      ),
      AnswerOption(text: 'Economics / Business Math', targetCode: 'BUS'),
      AnswerOption(
        text: 'Values Education / activities involving people and culture',
        targetCode: 'HM',
      ),
      AnswerOption(text: 'English, Filipino, or the Arts', targetCode: 'HUM'),
      AnswerOption(text: 'Science / Biology', targetCode: 'HS'),
      AnswerOption(
        text: 'Civic / Values focused on law, rules, and order',
        targetCode: 'CRIM',
      ),
    ],
  ),
  AssessmentQuestion(
    id: 3,
    question: 'What kind of work environment appeals to you?',
    options: [
      AnswerOption(
        text: 'Office or remote, working with software and systems',
        targetCode: 'IT',
      ),
      AnswerOption(
        text: 'Field sites, laboratories, construction sites, or technical plants',
        targetCode: 'ENG',
      ),
      AnswerOption(text: 'A classroom', targetCode: 'ED'),
      AnswerOption(
        text: 'A corporate office, bank, or finance firm',
        targetCode: 'BUS',
      ),
      AnswerOption(text: 'Hotels, resorts, or airlines', targetCode: 'HM'),
      AnswerOption(
        text: 'A media company, studio, agency, or clinic setting for counseling',
        targetCode: 'HUM',
      ),
      AnswerOption(text: 'A hospital or clinic', targetCode: 'HS'),
      AnswerOption(
        text: 'A police station, court, or law enforcement agency',
        targetCode: 'CRIM',
      ),
    ],
  ),
  AssessmentQuestion(
    id: 4,
    question: 'What is your natural strength?',
    options: [
      AnswerOption(
        text: 'Logical thinking and problem-solving with technology',
        targetCode: 'IT',
      ),
      AnswerOption(
        text: 'Spatial and mechanical reasoning',
        targetCode: 'ENG',
      ),
      AnswerOption(
        text: 'Patience and communicating with people',
        targetCode: 'ED',
      ),
      AnswerOption(
        text: 'Numerical analysis and persuasion',
        targetCode: 'BUS',
      ),
      AnswerOption(
        text: 'Hospitality and interpersonal warmth',
        targetCode: 'HM',
      ),
      AnswerOption(
        text: 'Creativity, expression, or understanding people\'s behavior',
        targetCode: 'HUM',
      ),
      AnswerOption(
        text: 'Empathy and staying composed under pressure',
        targetCode: 'HS',
      ),
      AnswerOption(
        text: 'Observation skills and a strong sense of justice',
        targetCode: 'CRIM',
      ),
    ],
  ),
  AssessmentQuestion(
    id: 5,
    question: 'What impact do you want to have in your future career?',
    options: [
      AnswerOption(
        text: 'Build digital solutions and innovate with technology',
        targetCode: 'IT',
      ),
      AnswerOption(
        text: 'Build infrastructure or machines that improve people\'s lives',
        targetCode: 'ENG',
      ),
      AnswerOption(
        text: 'Shape and guide the next generation',
        targetCode: 'ED',
      ),
      AnswerOption(
        text: 'Help businesses grow and manage finances well',
        targetCode: 'BUS',
      ),
      AnswerOption(
        text: 'Create memorable experiences for travelers and guests',
        targetCode: 'HM',
      ),
      AnswerOption(
        text: 'Inform, entertain, or help people understand themselves',
        targetCode: 'HUM',
      ),
      AnswerOption(text: 'Save lives and take care of the sick', targetCode: 'HS'),
      AnswerOption(
        text: 'Keep communities safe and uphold justice',
        targetCode: 'CRIM',
      ),
    ],
  ),
  AssessmentQuestion(
    id: 6,
    question: 'How do you prefer to solve problems?',
    options: [
      AnswerOption(
        text: 'Breaking a problem into small, logical steps until it works',
        targetCode: 'IT',
      ),
      AnswerOption(
        text: 'Applying scientific and engineering principles',
        targetCode: 'ENG',
      ),
      AnswerOption(
        text: 'Explaining concepts step by step to others',
        targetCode: 'ED',
      ),
      AnswerOption(
        text: 'Analyzing numbers, trends, and markets',
        targetCode: 'BUS',
      ),
      AnswerOption(
        text: 'Adjusting quickly to guest or customer needs',
        targetCode: 'HM',
      ),
      AnswerOption(
        text: 'Through storytelling, design, or understanding emotions',
        targetCode: 'HUM',
      ),
      AnswerOption(
        text: 'Following medical protocols calmly and carefully',
        targetCode: 'HS',
      ),
      AnswerOption(
        text: 'Gathering evidence and facts methodically',
        targetCode: 'CRIM',
      ),
    ],
  ),
  AssessmentQuestion(
    id: 7,
    question: 'Which tasks energize you the most?',
    options: [
      AnswerOption(
        text: 'Building software, websites, or systems',
        targetCode: 'IT',
      ),
      AnswerOption(
        text: 'Designing or building physical structures, machines, or circuits',
        targetCode: 'ENG',
      ),
      AnswerOption(
        text: 'Teaching, mentoring, or guiding others',
        targetCode: 'ED',
      ),
      AnswerOption(
        text: 'Handling accounts, sales, or marketing campaigns',
        targetCode: 'BUS',
      ),
      AnswerOption(
        text: 'Organizing events or welcoming and assisting guests',
        targetCode: 'HM',
      ),
      AnswerOption(
        text: 'Creating content, counseling, or communicating ideas',
        targetCode: 'HUM',
      ),
      AnswerOption(
        text: 'Assisting patients or performing medical/health procedures',
        targetCode: 'HS',
      ),
      AnswerOption(
        text: 'Patrolling, investigating, or enforcing rules',
        targetCode: 'CRIM',
      ),
    ],
  ),
];

/// PHASE 2 — Department-specific questionnaires for every department with
/// more than one program. Each option maps 1:1 to one of that department's
/// programs.
const Map<String, List<AssessmentQuestion>> phase2QuestionsByDepartment = {
  'IT': [
    AssessmentQuestion(
      id: 1,
      question: 'Which project excites you most?',
      options: [
        AnswerOption(
          text: 'Analyzing large datasets to find trends and predictions',
          targetCode: 'IT1',
        ),
        AnswerOption(
          text: 'Designing and building an interactive website',
          targetCode: 'IT2',
        ),
        AnswerOption(
          text: 'Creating animations, graphics, or game assets',
          targetCode: 'IT3',
        ),
        AnswerOption(
          text: 'Securing a company\'s network from hackers',
          targetCode: 'IT4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 2,
      question: 'Which tool or skill would you like to master?',
      options: [
        AnswerOption(text: 'Python, R, and Machine Learning', targetCode: 'IT1'),
        AnswerOption(
          text: 'HTML, CSS, JavaScript, and web frameworks',
          targetCode: 'IT2',
        ),
        AnswerOption(
          text: 'Adobe Creative Suite and 3D modeling tools',
          targetCode: 'IT3',
        ),
        AnswerOption(
          text: 'Network security and ethical hacking tools',
          targetCode: 'IT4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 3,
      question: 'What kind of problem do you enjoy solving?',
      options: [
        AnswerOption(
          text: 'Finding hidden patterns and predictions in numbers',
          targetCode: 'IT1',
        ),
        AnswerOption(
          text: 'Making a website look good and run smoothly',
          targetCode: 'IT2',
        ),
        AnswerOption(
          text: 'Making visuals and stories come to life',
          targetCode: 'IT3',
        ),
        AnswerOption(
          text: 'Finding and fixing security vulnerabilities',
          targetCode: 'IT4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 4,
      question: 'Which career sounds most appealing?',
      options: [
        AnswerOption(text: 'Data Scientist / Data Analyst', targetCode: 'IT1'),
        AnswerOption(
          text: 'Web Developer (Front-end or Back-end)',
          targetCode: 'IT2',
        ),
        AnswerOption(
          text: 'Graphic / Animation / Game Designer',
          targetCode: 'IT3',
        ),
        AnswerOption(
          text: 'Cybersecurity Specialist / Network Administrator',
          targetCode: 'IT4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 5,
      question: 'Which related activity did you enjoy?',
      options: [
        AnswerOption(
          text: 'Statistics and math-based puzzles',
          targetCode: 'IT1',
        ),
        AnswerOption(text: 'Building simple web pages', targetCode: 'IT2'),
        AnswerOption(
          text: 'Drawing, editing videos or photos',
          targetCode: 'IT3',
        ),
        AnswerOption(
          text: 'Learning how systems can be hacked or protected',
          targetCode: 'IT4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 6,
      question: 'Pick a preferred work style.',
      options: [
        AnswerOption(
          text: 'Deep, focused analysis with data',
          targetCode: 'IT1',
        ),
        AnswerOption(
          text: 'Iterative building and testing of web features',
          targetCode: 'IT2',
        ),
        AnswerOption(
          text: 'Creative, visual, artistic work',
          targetCode: 'IT3',
        ),
        AnswerOption(
          text: 'Vigilant, detail-oriented monitoring',
          targetCode: 'IT4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 7,
      question: 'Which app would you rather build?',
      options: [
        AnswerOption(
          text: 'An app that predicts trends from data',
          targetCode: 'IT1',
        ),
        AnswerOption(
          text: 'An e-commerce or booking website',
          targetCode: 'IT2',
        ),
        AnswerOption(text: 'An animated short film or game', targetCode: 'IT3'),
        AnswerOption(
          text: 'A secure login or network-monitoring system',
          targetCode: 'IT4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 8,
      question: 'What motivates you most in IT?',
      options: [
        AnswerOption(
          text: 'Uncovering insights hidden in data',
          targetCode: 'IT1',
        ),
        AnswerOption(
          text: 'Bringing designs to life on the web',
          targetCode: 'IT2',
        ),
        AnswerOption(
          text: 'Expressing creativity digitally',
          targetCode: 'IT3',
        ),
        AnswerOption(
          text: 'Protecting people and systems from threats',
          targetCode: 'IT4',
        ),
      ],
    ),
  ],
  'ENG': [
    AssessmentQuestion(
      id: 1,
      question: 'Which structure or system interests you most?',
      options: [
        AnswerOption(text: 'Buildings, bridges, and roads', targetCode: 'ENG1'),
        AnswerOption(
          text: 'Computer hardware and embedded systems',
          targetCode: 'ENG2',
        ),
        AnswerOption(
          text: 'Power plants and electrical grids',
          targetCode: 'ENG3',
        ),
        AnswerOption(
          text: 'Circuits, gadgets, and communication devices',
          targetCode: 'ENG4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 2,
      question: 'Which subject did you enjoy?',
      options: [
        AnswerOption(
          text: 'Physics with a focus on construction/materials',
          targetCode: 'ENG1',
        ),
        AnswerOption(
          text: 'Programming combined with hardware',
          targetCode: 'ENG2',
        ),
        AnswerOption(
          text: 'Physics with a focus on electricity and magnetism',
          targetCode: 'ENG3',
        ),
        AnswerOption(
          text: 'Physics with a focus on electronics and circuits',
          targetCode: 'ENG4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 3,
      question: 'What kind of project excites you?',
      options: [
        AnswerOption(
          text: 'Designing a building or bridge',
          targetCode: 'ENG1',
        ),
        AnswerOption(
          text: 'Building a computer or robot circuit board',
          targetCode: 'ENG2',
        ),
        AnswerOption(
          text: 'Designing a power distribution system',
          targetCode: 'ENG3',
        ),
        AnswerOption(
          text: 'Designing a communication device or gadget',
          targetCode: 'ENG4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 4,
      question: 'Which career do you prefer?',
      options: [
        AnswerOption(text: 'Civil / Structural Engineer', targetCode: 'ENG1'),
        AnswerOption(text: 'Computer / Hardware Engineer', targetCode: 'ENG2'),
        AnswerOption(
          text: 'Electrical / Power Engineer',
          targetCode: 'ENG3',
        ),
        AnswerOption(
          text: 'Electronics / Communications Engineer',
          targetCode: 'ENG4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 5,
      question: 'Which tool would you like to use?',
      options: [
        AnswerOption(
          text: 'AutoCAD and structural design software',
          targetCode: 'ENG1',
        ),
        AnswerOption(
          text: 'Microcontrollers, circuit boards, and code',
          targetCode: 'ENG2',
        ),
        AnswerOption(
          text: 'Power system simulators',
          targetCode: 'ENG3',
        ),
        AnswerOption(
          text: 'Signal processing and electronic test tools',
          targetCode: 'ENG4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 6,
      question: 'Pick a preferred work environment.',
      options: [
        AnswerOption(text: 'Construction site', targetCode: 'ENG1'),
        AnswerOption(
          text: 'Tech / hardware laboratory',
          targetCode: 'ENG2',
        ),
        AnswerOption(
          text: 'Power plant or utility company',
          targetCode: 'ENG3',
        ),
        AnswerOption(
          text: 'Electronics or telecom company',
          targetCode: 'ENG4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 7,
      question: 'Which everyday phenomenon interests you more?',
      options: [
        AnswerOption(
          text: 'How buildings withstand earthquakes',
          targetCode: 'ENG1',
        ),
        AnswerOption(
          text: 'How computers and robots work',
          targetCode: 'ENG2',
        ),
        AnswerOption(
          text: 'How electricity gets to your home',
          targetCode: 'ENG3',
        ),
        AnswerOption(
          text: 'How phones and gadgets communicate',
          targetCode: 'ENG4',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 8,
      question: 'What motivates you most in engineering?',
      options: [
        AnswerOption(
          text: 'Building lasting infrastructure',
          targetCode: 'ENG1',
        ),
        AnswerOption(
          text: 'Merging hardware and software',
          targetCode: 'ENG2',
        ),
        AnswerOption(text: 'Powering communities', targetCode: 'ENG3'),
        AnswerOption(
          text: 'Innovating communication technology',
          targetCode: 'ENG4',
        ),
      ],
    ),
  ],
  'ED': [
    AssessmentQuestion(
      id: 1,
      question: 'Which learners do you want to teach?',
      options: [
        AnswerOption(text: 'Toddlers and preschoolers', targetCode: 'ED1'),
        AnswerOption(
          text: 'Grade-school children, all subjects',
          targetCode: 'ED2',
        ),
        AnswerOption(text: 'Teens — English / literature', targetCode: 'ED3'),
        AnswerOption(text: 'Teens — Filipino / panitikan', targetCode: 'ED4'),
        AnswerOption(text: 'Teens — Mathematics', targetCode: 'ED5'),
        AnswerOption(text: 'Teens — Science', targetCode: 'ED6'),
        AnswerOption(text: 'Learners with special needs', targetCode: 'ED7'),
      ],
    ),
    AssessmentQuestion(
      id: 2,
      question: 'Which subject would you love to teach?',
      options: [
        AnswerOption(
          text: 'Basic motor and social skills for young children',
          targetCode: 'ED1',
        ),
        AnswerOption(
          text: 'General subjects (reading, basic math, etc.)',
          targetCode: 'ED2',
        ),
        AnswerOption(
          text: 'English grammar and literature',
          targetCode: 'ED3',
        ),
        AnswerOption(
          text: 'Filipino grammar and literature',
          targetCode: 'ED4',
        ),
        AnswerOption(text: 'Algebra, geometry, and calculus', targetCode: 'ED5'),
        AnswerOption(
          text: 'Biology, chemistry, and physics',
          targetCode: 'ED6',
        ),
        AnswerOption(
          text: 'Individualized/adaptive learning strategies',
          targetCode: 'ED7',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 3,
      question: 'Which teaching setting appeals to you?',
      options: [
        AnswerOption(text: 'Daycare or preschool classroom', targetCode: 'ED1'),
        AnswerOption(text: 'Elementary classroom', targetCode: 'ED2'),
        AnswerOption(text: 'High school English class', targetCode: 'ED3'),
        AnswerOption(text: 'High school Filipino class', targetCode: 'ED4'),
        AnswerOption(text: 'High school Math class', targetCode: 'ED5'),
        AnswerOption(
          text: 'High school Science laboratory',
          targetCode: 'ED6',
        ),
        AnswerOption(
          text: 'Inclusive / special-education classroom',
          targetCode: 'ED7',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 4,
      question: 'Which skill do you want to build?',
      options: [
        AnswerOption(
          text: 'Nurturing and child development',
          targetCode: 'ED1',
        ),
        AnswerOption(
          text: 'Teaching foundational multi-subject skills',
          targetCode: 'ED2',
        ),
        AnswerOption(
          text: 'Communication and literary analysis',
          targetCode: 'ED3',
        ),
        AnswerOption(text: 'Wika at panitikan', targetCode: 'ED4'),
        AnswerOption(
          text: 'Logical and mathematical reasoning',
          targetCode: 'ED5',
        ),
        AnswerOption(
          text: 'Scientific inquiry and experimentation',
          targetCode: 'ED6',
        ),
        AnswerOption(
          text: 'Adaptive teaching techniques for diverse learners',
          targetCode: 'ED7',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 5,
      question: 'Which activity sounds fun to you?',
      options: [
        AnswerOption(
          text: 'Playing with and guiding young children',
          targetCode: 'ED1',
        ),
        AnswerOption(
          text: 'Teaching a mix of subjects to children',
          targetCode: 'ED2',
        ),
        AnswerOption(text: 'Discussing novels and essays', targetCode: 'ED3'),
        AnswerOption(
          text: 'Discussing Filipino literature',
          targetCode: 'ED4',
        ),
        AnswerOption(
          text: 'Solving math problems together',
          targetCode: 'ED5',
        ),
        AnswerOption(
          text: 'Conducting science experiments',
          targetCode: 'ED6',
        ),
        AnswerOption(
          text: 'Creating individualized learning plans',
          targetCode: 'ED7',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 6,
      question: 'What impact do you want as a teacher?',
      options: [
        AnswerOption(text: 'Build strong early foundations', targetCode: 'ED1'),
        AnswerOption(
          text: 'Give children their first love of learning',
          targetCode: 'ED2',
        ),
        AnswerOption(
          text: 'Improve students\' English communication',
          targetCode: 'ED3',
        ),
        AnswerOption(
          text: 'Preserve Filipino language and culture',
          targetCode: 'ED4',
        ),
        AnswerOption(
          text: 'Build students\' problem-solving skills',
          targetCode: 'ED5',
        ),
        AnswerOption(
          text: 'Spark curiosity about the natural world',
          targetCode: 'ED6',
        ),
        AnswerOption(
          text: 'Empower learners with special needs',
          targetCode: 'ED7',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 7,
      question: 'Which classroom scenario appeals to you most?',
      options: [
        AnswerOption(text: 'Comforting a crying toddler', targetCode: 'ED1'),
        AnswerOption(
          text: 'Teaching reading to 8-year-olds',
          targetCode: 'ED2',
        ),
        AnswerOption(
          text: 'Leading a debate on a novel',
          targetCode: 'ED3',
        ),
        AnswerOption(
          text: 'Leading a discussion on a Filipino text',
          targetCode: 'ED4',
        ),
        AnswerOption(
          text: 'Explaining a tricky math proof',
          targetCode: 'ED5',
        ),
        AnswerOption(
          text: 'Guiding a laboratory experiment',
          targetCode: 'ED6',
        ),
        AnswerOption(
          text: 'Adapting a lesson for a student with learning difficulties',
          targetCode: 'ED7',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 8,
      question: 'What motivates you most in teaching?',
      options: [
        AnswerOption(
          text: 'Shaping early childhood development',
          targetCode: 'ED1',
        ),
        AnswerOption(
          text: 'Being a child\'s first teacher',
          targetCode: 'ED2',
        ),
        AnswerOption(
          text: 'Inspiring love for English language/literature',
          targetCode: 'ED3',
        ),
        AnswerOption(
          text: 'Preserving and teaching Filipino heritage',
          targetCode: 'ED4',
        ),
        AnswerOption(
          text: 'Making math click for students',
          targetCode: 'ED5',
        ),
        AnswerOption(
          text: 'Igniting scientific curiosity',
          targetCode: 'ED6',
        ),
        AnswerOption(
          text: 'Making education inclusive for everyone',
          targetCode: 'ED7',
        ),
      ],
    ),
  ],
  'BUS': [
    AssessmentQuestion(
      id: 1,
      question: 'Which task appeals to you most?',
      options: [
        AnswerOption(
          text: 'Auditing financial records for accuracy',
          targetCode: 'BUS1',
        ),
        AnswerOption(
          text: 'Analyzing investments and managing funds',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Creating campaigns to sell a product',
          targetCode: 'BUS3',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 2,
      question: 'Which subject did you enjoy?',
      options: [
        AnswerOption(
          text: 'Bookkeeping and accounting principles',
          targetCode: 'BUS1',
        ),
        AnswerOption(
          text: 'Math focused on finance and economics',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Advertising and consumer behavior',
          targetCode: 'BUS3',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 3,
      question: 'Which career sounds appealing?',
      options: [
        AnswerOption(
          text: 'Certified Public Accountant / Auditor',
          targetCode: 'BUS1',
        ),
        AnswerOption(
          text: 'Financial Analyst / Investment Manager',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Marketing Manager / Brand Strategist',
          targetCode: 'BUS3',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 4,
      question: 'Which daily task would you prefer?',
      options: [
        AnswerOption(
          text: 'Preparing financial statements',
          targetCode: 'BUS1',
        ),
        AnswerOption(
          text: 'Managing budgets and investment portfolios',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Designing promotions and branding',
          targetCode: 'BUS3',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 5,
      question: 'Which skill matters most to you?',
      options: [
        AnswerOption(
          text: 'Precision and attention to detail with numbers',
          targetCode: 'BUS1',
        ),
        AnswerOption(
          text: 'Strategic financial decision-making',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Creativity and persuasion',
          targetCode: 'BUS3',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 6,
      question: 'Pick a project you\'d enjoy.',
      options: [
        AnswerOption(text: 'Reconciling a company\'s books', targetCode: 'BUS1'),
        AnswerOption(
          text: 'Building an investment plan',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Launching a product campaign',
          targetCode: 'BUS3',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 7,
      question: 'What work style suits you?',
      options: [
        AnswerOption(
          text: 'Rule-based, compliance-focused work',
          targetCode: 'BUS1',
        ),
        AnswerOption(
          text: 'Analytical, risk-based decision making',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Creative, people-facing strategy work',
          targetCode: 'BUS3',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 8,
      question: 'What motivates you most in business?',
      options: [
        AnswerOption(
          text: 'Ensuring financial accuracy and integrity',
          targetCode: 'BUS1',
        ),
        AnswerOption(
          text: 'Growing wealth and managing resources',
          targetCode: 'BUS2',
        ),
        AnswerOption(
          text: 'Connecting brands with customers',
          targetCode: 'BUS3',
        ),
      ],
    ),
  ],
  'HM': [
    AssessmentQuestion(
      id: 1,
      question: 'Which setting appeals to you?',
      options: [
        AnswerOption(
          text: 'Hotels, restaurants, and resorts',
          targetCode: 'HM1',
        ),
        AnswerOption(
          text: 'Travel agencies, airlines, and tour companies',
          targetCode: 'HM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 2,
      question: 'Which task excites you?',
      options: [
        AnswerOption(
          text: 'Managing hotel or restaurant operations',
          targetCode: 'HM1',
        ),
        AnswerOption(
          text: 'Planning travel itineraries and tours',
          targetCode: 'HM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 3,
      question: 'Which career do you prefer?',
      options: [
        AnswerOption(
          text: 'Hotel / Restaurant Manager',
          targetCode: 'HM1',
        ),
        AnswerOption(
          text: 'Tour Guide / Travel Consultant',
          targetCode: 'HM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 4,
      question: 'Which skill matters most?',
      options: [
        AnswerOption(
          text: 'Guest service and operations management',
          targetCode: 'HM1',
        ),
        AnswerOption(
          text: 'Destination knowledge and itinerary planning',
          targetCode: 'HM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 5,
      question: 'Which activity sounds fun?',
      options: [
        AnswerOption(
          text: 'Organizing a fine-dining experience',
          targetCode: 'HM1',
        ),
        AnswerOption(
          text: 'Planning a group\'s dream vacation',
          targetCode: 'HM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 6,
      question: 'What impact do you want?',
      options: [
        AnswerOption(
          text: 'Create memorable stays for guests',
          targetCode: 'HM1',
        ),
        AnswerOption(
          text: 'Help people explore the world',
          targetCode: 'HM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 7,
      question: 'Pick a preferred work environment.',
      options: [
        AnswerOption(text: 'Hotel, resort, or restaurant', targetCode: 'HM1'),
        AnswerOption(
          text: 'Airport, travel agency, or tour bus',
          targetCode: 'HM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 8,
      question: 'What motivates you most?',
      options: [
        AnswerOption(
          text: 'Excellence in hospitality service',
          targetCode: 'HM1',
        ),
        AnswerOption(
          text: 'Showcasing destinations and culture',
          targetCode: 'HM2',
        ),
      ],
    ),
  ],
  'HUM': [
    AssessmentQuestion(
      id: 1,
      question: 'Which activity appeals to you?',
      options: [
        AnswerOption(
          text: 'Writing, broadcasting, or producing media',
          targetCode: 'HUM1',
        ),
        AnswerOption(
          text: 'Understanding why people think, feel, and act the way they do',
          targetCode: 'HUM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 2,
      question: 'Which subject did you enjoy?',
      options: [
        AnswerOption(
          text: 'Journalism and media studies',
          targetCode: 'HUM1',
        ),
        AnswerOption(
          text: 'Human behavior and social science',
          targetCode: 'HUM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 3,
      question: 'Which career do you prefer?',
      options: [
        AnswerOption(
          text: 'Journalist / Broadcaster / PR Specialist',
          targetCode: 'HUM1',
        ),
        AnswerOption(
          text: 'Counselor / HR Specialist / Psychologist',
          targetCode: 'HUM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 4,
      question: 'Which skill matters most?',
      options: [
        AnswerOption(
          text: 'Storytelling and media production',
          targetCode: 'HUM1',
        ),
        AnswerOption(
          text: 'Listening and understanding emotions/behavior',
          targetCode: 'HUM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 5,
      question: 'Which activity sounds fun?',
      options: [
        AnswerOption(
          text: 'Producing a video or podcast',
          targetCode: 'HUM1',
        ),
        AnswerOption(
          text: 'Studying why people behave a certain way',
          targetCode: 'HUM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 6,
      question: 'What impact do you want?',
      options: [
        AnswerOption(
          text: 'Inform and entertain the public',
          targetCode: 'HUM1',
        ),
        AnswerOption(
          text: 'Help people understand themselves and improve wellbeing',
          targetCode: 'HUM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 7,
      question: 'Pick a preferred work environment.',
      options: [
        AnswerOption(text: 'Media company, studio, or agency', targetCode: 'HUM1'),
        AnswerOption(
          text: 'Clinic, HR office, or research lab',
          targetCode: 'HUM2',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 8,
      question: 'What motivates you most?',
      options: [
        AnswerOption(
          text: 'Sharing stories that matter',
          targetCode: 'HUM1',
        ),
        AnswerOption(
          text: 'Helping people through psychological insight',
          targetCode: 'HUM2',
        ),
      ],
    ),
  ],
};

/// Confirmation questionnaires for one-program departments.
///
/// Point key: Yes = 2 | Somewhat = 1 | No = 0. A total of 16 points is
/// possible; a program is a STRONG fit at >= 12, MODERATE at 7-11, LOW at 0-6.
const Map<String, List<ConfirmationQuestion>> confirmationQuestionsByDepartment = {
  'HS': [
    ConfirmationQuestion(
      id: 1,
      question: 'Are you comfortable caring for sick or injured people?',
      programCode: 'HS1',
    ),
    ConfirmationQuestion(
      id: 2,
      question: 'Do you enjoy science subjects like Biology and Anatomy?',
      programCode: 'HS1',
    ),
    ConfirmationQuestion(
      id: 3,
      question:
          'Can you stay calm and think clearly in stressful or emergency situations?',
      programCode: 'HS1',
    ),
    ConfirmationQuestion(
      id: 4,
      question:
          'Are you willing to work in hospitals/clinics, including shifting schedules?',
      programCode: 'HS1',
    ),
    ConfirmationQuestion(
      id: 5,
      question: 'Do you find satisfaction in helping or comforting others?',
      programCode: 'HS1',
    ),
    ConfirmationQuestion(
      id: 6,
      question:
          'Are you interested in learning medical procedures (injections, wound care, vital signs, etc.)?',
      programCode: 'HS1',
    ),
    ConfirmationQuestion(
      id: 7,
      question: 'Can you handle physically demanding, hands-on work?',
      programCode: 'HS1',
    ),
    ConfirmationQuestion(
      id: 8,
      question: 'Do you see yourself as a future nurse or healthcare provider?',
      programCode: 'HS1',
    ),
  ],
  'CRIM': [
    ConfirmationQuestion(
      id: 1,
      question: 'Are you interested in law enforcement and the justice system?',
      programCode: 'CRIM1',
    ),
    ConfirmationQuestion(
      id: 2,
      question: 'Do you enjoy investigating and solving problems logically?',
      programCode: 'CRIM1',
    ),
    ConfirmationQuestion(
      id: 3,
      question:
          'Are you comfortable with physical training and discipline (drills, fitness)?',
      programCode: 'CRIM1',
    ),
    ConfirmationQuestion(
      id: 4,
      question: 'Do you have a strong sense of justice and respect for the rule of law?',
      programCode: 'CRIM1',
    ),
    ConfirmationQuestion(
      id: 5,
      question: 'Are you interested in forensic science or understanding criminal behavior?',
      programCode: 'CRIM1',
    ),
    ConfirmationQuestion(
      id: 6,
      question: 'Can you handle high-pressure, high-risk situations?',
      programCode: 'CRIM1',
    ),
    ConfirmationQuestion(
      id: 7,
      question: 'Are you open to a career in the police, jail management, or security services?',
      programCode: 'CRIM1',
    ),
    ConfirmationQuestion(
      id: 8,
      question: 'Do you see yourself as a future law enforcer or criminologist?',
      programCode: 'CRIM1',
    ),
  ],
};
