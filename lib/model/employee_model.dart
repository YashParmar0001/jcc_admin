class EmployeeModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String employeeId;
  final String phone;
  final String email;
  final String ward;
  final String password;

  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        employeeId,
        phone,
        email,
        ward,
        password,
      ];

  const EmployeeModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.employeeId,
    required this.phone,
    required this.email,
    required this.ward,
    required this.password,
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
    String? ward,
    String? password,
  }) {
    return EmployeeModel(
      firstName: this.firstName,
      middleName: this.middleName,
      lastName: this.lastName,
      employeeId: this.employeeId,
      phone: this.phone,
      email: this.email,
      ward: this.ward,
      password: this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      employeeId: employeeId,
      phone: phone,
      email: email,
      ward: ward,
      password: password,
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
      ward: map['ward'],
      password: map['password'],
    );
  }
}
