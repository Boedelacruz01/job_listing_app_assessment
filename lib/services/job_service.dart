import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job.dart';

class JobService {
  final CollectionReference _db = FirebaseFirestore.instance.collection('jobs');

  // ✅ Stream all jobs
  Stream<List<Job>> getJobs() {
    return _db.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Job.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // ✅ Stream jobs created by a specific user
  Stream<List<Job>> getJobsByUser(String userId) {
    return _db.where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Job.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // ✅ Add a new job with Firestore-generated ID
  Future<void> addJob(Job job) async {
    final docRef = await _db.add(job.toMap());
    // Update the job with its Firestore ID
    await docRef.update({'id': docRef.id});
  }

  // ✅ Get a single job by ID
  Future<Job?> getJobById(String id) async {
    final doc = await _db.doc(id).get();
    if (doc.exists) {
      return Job.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // ✅ Delete a job by ID
  Future<void> deleteJob(String id) async {
    await _db.doc(id).delete();
  }
}
