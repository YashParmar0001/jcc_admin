import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jcc_admin/model/employee_model.dart';
import 'dart:developer' as dev;
class EmployeeRepository {
  EmployeeRepository({
    FirebaseFirestore? firebaseFirestore,
  })  : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<EmployeeModel>> getEmployeeList() {
    return _firestore.collection('employees').snapshots().map((event) {
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
      Map<String, dynamic> employeeData) async {
    try {
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

  Future<void> removeEmployee(String email) async {
    try {
      await _firestore
          .collection('employees')
          .doc(email).delete();
    } catch(e){
      print(e.toString());
    }
  }
}
