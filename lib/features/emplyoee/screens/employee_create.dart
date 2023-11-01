import 'package:flutter/material.dart';
import 'package:jcc_admin/common/widget/primary_button.dart';

class EmployeeCreate extends StatelessWidget {
  const EmployeeCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputFields(
                    context: context,
                    title: "First Name:",
                    hint: "Enter first name",
                    onChnaged: (val) {}),
                _buildInputFields(
                    context: context,
                    title: "Middle Name:",
                    hint: "Enter middle name",
                    onChnaged: (val) {}),
                _buildInputFields(
                    context: context,
                    title: "Last Name:",
                    hint: "Enter last name",
                    onChnaged: (val) {}),
                _buildInputFields(
                    context: context,
                    title: "Employee ID:",
                    hint: "Enter employee ID",
                    onChnaged: (val) {}),
                _buildInputFields(
                    context: context,
                    title: "Phone No:",
                    hint: "+91 987654321",
                    onChnaged: (val) {}),
                _buildInputFields(
                    context: context,
                    title: "Email",
                    hint: "Enter email",
                    onChnaged: (val) {}),
                const SizedBox(height: 10),
                const Text(
                  "Ward no:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Select ward",
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Ward 1",
                      child : Text("Ward 1"),
                    ),
                    DropdownMenuItem(
                      value: "Ward 2",
                      child: Text("Ward 2"),
                    ),
                    DropdownMenuItem(
                      value: "Ward 3",
                      child: Text("Ward 3"),
                    ),
                    DropdownMenuItem(
                      value: "Ward 4",
                      child: Text("Ward 4"),
                    ),
                  ],
                  onChanged: (val) {},
                ),
                const SizedBox(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("sfd9894(&-0"),
                    const Expanded(child: SizedBox()),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.sync))
                  ],
                ),
                PrimaryButton(onTap: () {}, title: "Create Employee")
              ],
            )),
      ),
    );
  }

  Widget _buildInputFields(
      {required BuildContext context,
      required String title,
      required String hint,
      required Function onChnaged}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hint,
          ),
          onChanged: (value) => onChnaged(value),
        )
      ],
    );
  }
}
