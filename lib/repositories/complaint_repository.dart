import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jcc_admin/model/complaint_model.dart';
import 'dart:developer' as dev;
import '../model/complaint_stats_model.dart';

class ComplaintRepository {
  ComplaintRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance, _storage = FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  Stream<List<ComplaintModel>> getComplaints(String department) {
    return _firestore
        .collection('complaints')
        .where('departmentName', isEqualTo: department)
        .orderBy('registrationDate', descending: true)
        .snapshots()
        .map(
      (event) {
        return event.docs.map((e) => ComplaintModel.fromMap(e.data())).toList();
      },
    );
  }

  Stream<List<ComplaintModel>> getRecentComplaints() {
    return _firestore
        .collection('complaints')
        .orderBy('registrationDate', descending: true)
        .limit(15)
        .snapshots()
        .map(
      (event) {
        return event.docs.map((e) => ComplaintModel.fromMap(e.data())).toList();
      },
    );
  }

  Future<List<String>> uploadFiles(String id, List<File> files) async {
    List<String> urls = [];
    int count = 1;
    for (var file in files) {
      final ref = _storage.ref().child(
        'complaint_res_photographs/cid_${id}_img_$count.jpg',
      );
      await ref
          .putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .then((value) async {
        await value.ref.getDownloadURL().then((value) {
          urls.add(value);
        });
      });
      count++;
    }
    return urls;
  }

  Stream<ComplaintModel?> getSelectedComplaint(String id) {
    return _firestore
        .collection('complaints')
        .doc(id)
        .snapshots()
        .map((e) => ComplaintModel.fromMap(e.data()!));
  }

  Future<void> updateComplaint(String id, Map<String, dynamic> data) async {
    return await _firestore.collection('complaints').doc(id).update(data);
  }

  Future<void> updateComplaintStats(Map<String, dynamic> data) async {
    return await _firestore
        .collection('complaint_stats')
        .doc('stats')
        .update(data);
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
