class EmployeeModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String employeeId;
  final String phone;
  final String email;
  final String department;
  final String ward;
  final String password;
  final String type;
  final String photoUrl;

  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        employeeId,
        phone,
        email,
        department,
        ward,
        password,
        type,
    photoUrl,
      ];

  const EmployeeModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.employeeId,
    required this.phone,
    required this.email,
    required this.department,
    required this.ward,
    required this.password,
    required this.type,
    required this.photoUrl,
  });

  @override
  String toString() {
    return 'EmployeeModel(firstName: $firstName, middleName: $middleName, lastName: $lastName, employeeId: $employeeId, phone: $phone, email: $email, ward: $ward, password: $password)';
  }

  EmployeeModel copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? employeeId,
    String? phone,
    String? email,
    String? department,
    String? ward,
    String? password,
    String? type,
    String? photoUrl,
  }) {
    return EmployeeModel(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      employeeId: employeeId ?? this.employeeId,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      department: department ?? this.department,
      ward: ward ?? this.ward,
      password: password ?? this.password,
      type: type ?? this.type,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'employeeId': employeeId,
      'phone': phone,
      'email': email,
      'department': department,
      'ward': ward,
      'password': password,
      'type': type,
      'photoUrl' : photoUrl,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      employeeId: map['employeeId'],
      phone: map['phone'],
      email: map['email'],
      department: map['department'] ?? "",
      ward: map['ward'],
      password: map['password'],
      type: map['type'],
      photoUrl: map['photoUrl'],
    );
  }
}
