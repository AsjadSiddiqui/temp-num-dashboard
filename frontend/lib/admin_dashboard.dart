import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:temp_phone_nums/models/phone_number.dart';

import 'view_models/phone_dashboard_view_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late Future<bool> fetchPhoneNumbers;

  @override
  void initState() {
    super.initState();

    fetchPhoneNumbers = Provider.of<PhoneDashboardViewModel>(context, listen: false).fetchPhoneNumbers();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PhoneDashboardViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          DropdownButton<String>(
            value: viewModel.filter,
            items: ['All', 'active', 'inactive'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.capitalize()),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) viewModel.setFilter(value);
            },
          ),
          const SizedBox(width: 16),
          DropdownButton<String>(
            value: viewModel.sortBy,
            items: ['Status', 'Messages', 'Phone Number'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) viewModel.setSortBy(value);
            },
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        future: fetchPhoneNumbers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (viewModel.phoneNumbers.isEmpty) {
            return const Center(
              child: Text('No phone numbers found'),
            );
          }

          return ListView.builder(
            itemCount: viewModel.phoneNumbers.length,
            itemBuilder: (context, index) {
              final phone = viewModel.phoneNumbers[index];
              return SizedBox(
                height: 120.h,
                child: ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 3),
                  title: Text('Phone: ${phone.number}'),
                  subtitle: Text('Status: ${phone.status.name.capitalize()}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Messages: ${phone.messages}'),
                      IconButton(
                        icon: Icon(
                          phone.status == PhoneNumberStatus.active ? Icons.toggle_on : Icons.toggle_off,
                          color: phone.status == PhoneNumberStatus.active ? Colors.green : Colors.red,
                        ),
                        onPressed: () {
                          viewModel.toggleStatus(phone);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
