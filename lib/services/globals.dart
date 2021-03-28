import 'services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Global {
  static final String title = 'CjPesco';

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models
  static final Map models = {
    Topic: (data) => Topic.fromMap(data),
    Quiz: (data) => Quiz.fromMap(data),
    Report: (data) => Report.fromMap(data),
  };

  // Firestore References for Writes
  static final Collection<Topic> topicsRef = Collection<Topic>(path: 'topics');
  static final UserData<Report> reportRef =
      UserData<Report>(collection: 'reports');
}
