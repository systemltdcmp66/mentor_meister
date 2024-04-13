
// Model for Upcoming Session
class UpcomingSession {
  final String studentName;
  final String courseTitle;
  final String time;
  final String duration;

  UpcomingSession({
    required this.studentName,
    required this.courseTitle,
    required this.time,
    required this.duration,
  });
}


  // Dummy data for demonstration
  final List<UpcomingSession> upcomingSessions = [
    UpcomingSession(
      studentName: 'Giuseppe Ficara',
      courseTitle: 'React.js from scratch',
      time: '08:00 AM',
      duration: '(1 Hour, 30 Min)',
    ),
    UpcomingSession(
      studentName: 'Giuseppe Ficara',
      courseTitle: 'React.js from scratch',
      time: '08:00 AM',
      duration: '(1 Hour, 30 Min)',
    ),  ];




