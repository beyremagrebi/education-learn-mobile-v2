enum DrawerItem {
  // Main Items
  newsFeed,
  dashboard,
  elimination,

  // Project Management
  projectManagement,
  projectLists, // Child of projectManagement

  // Administration
  administration,
  finance, // Child of administration
  users, // Child of administration

  // users
  collaborators, // Child of users
  instructors, // Child of users
  responsibles, // Child of users
  students, // Child of users
  // School
  school,
  events, // Child of school
  kanbanEvents, // Child of event
  listEvents,
  // Transcript (relevé de note)
  transcript,
  parameterMention, // Child of transcript
  parameterAdmission, // Child of transcript

  // Study Plan
  studyPlan,
  studyPlanAll, // Child of studyPlan
  setting, // Child of studyPlan
  domains, // Child of studyPlan
  departments, // Child of studyPlan
  training, // Child of studyPlan
  sector, // Child of studyPlan
  levels, // Child of studyPlan
  commonCore, // Child of studyPlan
  speciality, // Child of studyPlan
  career, // Child of studyPlan
  modules, // Child of studyPlan
  subjects, // Child of studyPlan

  // Classes
  classes,

  // Planning
  planning,
  configuration, // Child of planning
  classSchedule, // Child of planning
  teachersSchedule, // Child of planning

  invoice
}
