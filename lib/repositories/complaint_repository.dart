import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jcc_admin/model/complaint_model.dart';
import 'dart:developer' as dev;
import '../model/complaint_stats_model.dart';

class ComplaintRepository {
  ComplaintRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<ComplaintModel>> getComplaints(String department, String ward) {
    return _firestore
        .collection('complaints')
        .where('departmentName', isEqualTo: department)
        .where('ward', isEqualTo: ward)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => ComplaintModel.fromMap(e.data())).toList();
    });
  }

  Stream<ComplaintModel?> getSelectedComplaint(String id) {
    return _firestore
        .collection('complaints')
        .doc(id)
        .snapshots()
        .map((e) => ComplaintModel.fromMap(e.data()!));
  }

  Future<void> updateComplaintToTaken(String id, Map<String, dynamic> data) async {
    return await _firestore.collection('complaints').doc(id).update(data);
  }
    
  Stream<ComplaintStatsModel?> getComplaintStats() {
    return _firestore
        .collection('complaint_stats')
        .doc('stats')
        .snapshots()
        .map((event) {
      try {
        final data = event.data();
        return ComplaintStatsModel.fromMap(data!);
      } catch (e) {
        dev.log('Got complaint stats error: $e', name: 'Stats');
        return null;
      }
    });
  }
}
