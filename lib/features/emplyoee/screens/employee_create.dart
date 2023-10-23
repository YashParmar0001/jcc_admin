import 'package:flutter/material.dart';
import 'package:jcc_admin/common/widget/my_button.dart';

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
                _buildInputFields(context: context,
                    title: "First Name:",
                    hint: "Enter first name",
                    onChnaged: (val) {}),
                _buildInputFields(context: context,
                    title: "Middle Name:",
                    hint: "Enter middle name",
                    onChnaged: (val) {}),
                _buildInputFields(context: context,
                    title: "Last Name:",
                    hint: "Enter last name",
                    onChnaged: (val) {}),
                _buildInputFields(context: context,
                    title: "Employee ID:",
                    hint: "Enter employee ID",
                    onChnaged: (val) {}),
                _buildInputFields(context: context,
                    title: "Phone No:",
                    hint: "+91 987654321",
                    onChnaged: (val) {}),
                _buildInputFields(context: context,
                    title: "Email",
                    hint: "Enter email",
                    onChnaged: (val) {}),
                SizedBox(height: 10),
                Text(
                  "Ward no:",
                  style: const TextStyle(
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
                  items: [
                    DropdownMenuItem(
                      child: Text("Ward 1"),
                      value: "Ward 1",
                    ),
                    DropdownMenuItem(
                      child: Text("Ward 2"),
                      value: "Ward 2",
                    ),
                    DropdownMenuItem(
                      child: Text("Ward 3"),
                      value: "Ward 3",
                    ),
                    DropdownMenuItem(
                      child: Text("Ward 4"),
                      value: "Ward 4",
                    ),
                  ],
                  onChanged: (val) {},),
                SizedBox(height: 10),
                Text(
                  "Password",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text("sfd9894(&-0"),
                    Expanded(child: SizedBox()),
                    IconButton(onPressed: (){}, icon: Icon(Icons.sync))
                  ],
                ),
                MyButton(onTap: (){}, title: "Create Employee")
              ],
            )
        ),
      ),
    );
  }

  Widget _buildInputFields(
      {required BuildContext context, required String title, required String hint, required Function onChnaged}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
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
