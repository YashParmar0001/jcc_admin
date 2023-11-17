import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jcc_admin/model/employee_model.dart';
import 'dart:developer' as dev;

class EmployeeRepository {
  EmployeeRepository({
    FirebaseFirestore? firebaseFirestore,
    FirebaseStorage? storage,
  })  : _firestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  Stream<List<EmployeeModel>> getEmployeeList(String department) {
    dev.log('Getting employee list', name: 'Employee');
    return _firestore
        .collection('employees')
        .where('department', isEqualTo: department)
        .where('type', isEqualTo: 'employee')
        .snapshots()
        .map((event) {
      return event.docs
          .map(
            (e) => EmployeeModel.fromMap(
              e.data(),
            ),
          )
          .toList();
    });
  }

  Future<EmployeeModel?> registerEmployee(
    Map<String, dynamic> employeeData,
    File imageFile,
  ) async {
    try {
      try {
        final photoUrl = await uploadUserProfilePhoto(
          imageFile,
          employeeData['email'],
        );
        if (photoUrl == null) {
          return null;
        } else {
          employeeData['photoUrl'] = photoUrl;
          // return null;
        }
      } catch (e) {
        dev.log('Got error: $e', name: 'Register');
        return null;
      }

      final employee = EmployeeModel(
        firstName: employeeData['firstName'],
        middleName: employeeData['middleName'],
        lastName: employeeData['lastName'],
        employeeId: employeeData['employeeId'],
        phone: employeeData['phone'],
        email: employeeData['email'],
        ward: employeeData['ward'],
        password: employeeData['password'],
        department: employeeData['department'],
        type: employeeData['type'],
        photoUrl: employeeData['photoUrl'],
      );
      await _firestore
          .collection('employees')
          .doc(employee.email)
          .set(employee.toMap());
      return employee;
    } catch (e) {
      dev.log('Error while creating employee: $e', name: 'Employee');
      return null;
    }
  }

  Future<String?> uploadUserProfilePhoto(File imageFile, String email) async {
    try {
      await _storage.ref('employee_profiles/$email').putFile(
            imageFile,
            SettableMetadata(contentType: 'image/jpeg'),
          );
      dev.log('Successfully uploaded employee profile', name: 'Employee');
      return await _storage.ref('employee_profiles/$email').getDownloadURL();
    } catch (e) {
      dev.log('Error occurred while uploading user profile', name: 'Employee');
      return null;
    }
  }

  Stream<EmployeeModel?> getSelectedEmployee(String email) {
    return _firestore.collection('employees').doc(email).snapshots().map((e) {
      try {
        if (e.data() == null) {
          return null;
        } else {
          return EmployeeModel.fromMap(e.data()!);
        }
      }catch(e) {
        return null;
      }
    });
  }

  Future<String?> removeEmployee(String email) async {
    try {
      await _firestore.collection('employees').doc(email).delete();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
