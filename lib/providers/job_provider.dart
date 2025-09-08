import 'package:flutter/foundation.dart';
import '../models/job.dart';
import '../services/job_service.dart';

class JobProvider with ChangeNotifier {
  final JobService _jobService = JobService();

  List<Job> _jobs = [];
  List<Job> get jobs => _jobs;

  JobProvider() {
    _listenToJobs();
  }

  void _listenToJobs() {
    _jobService.getJobs().listen((jobList) {
      _jobs = jobList;
      notifyListeners();
    });
  }

  Future<void> addJob(Job job) async {
    await _jobService.addJob(job);
    // Firestore stream will update jobs automatically
  }

  Future<Job?> getJobById(String id) async {
    return await _jobService.getJobById(id);
  }
}
