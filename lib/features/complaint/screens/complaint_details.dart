import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jcc_admin/bloc/complaint/selected_complaint/selected_complaint_bloc.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';

class ComplaintDetails extends StatelessWidget {
  const ComplaintDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
      ),
      body: BlocBuilder<SelectedComplaintBloc, SelectedComplaintState>(
        builder: (context, state) {
          if (state is SelectedComplaintLoading) {
            return const CircularProgressIndicator();
          } else if (state is SelectedComplaintError) {
            return Text(state.message);
          } else if (state is SelectedComplaintLoaded) {
            final complaint = state.complaint;
            final employeeId = (context.read<LoginBloc>().state as LoggedIn)
                .employee
                .employeeId;

            return Column(
              children: [
                Text(complaint.toString()),
                ElevatedButton(
                  onPressed: () {
                    context.read<SelectedComplaintBloc>().add(
                          TakeComplaint(
                            assignedEmployeeId: employeeId,
                            complaint: complaint,
                          ),
                        );
                  },
                  child: const Text('Take Complaint'),
                ),
              ],
            );
          } else {
            return const Text('Unknown State');
          }
        },
      ),
    );
  }
}
