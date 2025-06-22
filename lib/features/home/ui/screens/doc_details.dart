import 'package:flutter/material.dart';
import '../../data/models/doc_model.dart';
import '../widgets/appointment_button.dart';
import '../widgets/dailog_add_reviw.dart';
import '../widgets/doctor_details_app_bar.dart';
import '../widgets/doctor_profile_section.dart';
import '../widgets/doctor_tab_bar_view.dart';
import '../widgets/doctor_tabs.dart';

class DoctorDetailsTabScreen extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorDetailsTabScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailsTabScreen> createState() => _DoctorDetailsTabScreenState();
}

class _DoctorDetailsTabScreenState extends State<DoctorDetailsTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DoctorDetailsAppBar(
        doctorName: widget.doctor.name,
        onReviewTap: _showReviewDialog,
      ),
      body: Column(
        children: [
          DoctorProfileSection(
            doctor: widget.doctor,
            onChatTap: _handleChatTap,
          ),
          DoctorTabBar(tabController: _tabController),
          DoctorTabBarView(
            tabController: _tabController,
            doctor: widget.doctor,
          ),
          AppointmentButton(
            onPressed: _handleAppointmentBooking,
          ),
        ],
      ),
    );
  }

  // Event Handlers
  void _showReviewDialog() {
    showReviewDialog(context, widget.doctor.doctorId);
  }

  void _handleChatTap() {
    // Implement chat functionality
    debugPrint('Chat tapped for doctor: ${widget.doctor.name}');
  }

  void _handleAppointmentBooking() {
    // Implement appointment booking
    debugPrint('Appointment booking for doctor: ${widget.doctor.name}');
  }
}
