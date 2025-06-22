import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logic/doctor_bloc.dart';
import '../widgets/widgets.home/booking_promotion_card.dart';
import '../widgets/widgets.home/doctor_recommendation_section.dart';
import '../widgets/widgets.home/header_section.dart';
import '../widgets/widgets.home/speciality_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadDoctors();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('Username') ?? '';
    });
  }

  void _loadDoctors() {
    context.read<DoctorBloc>().add(LoadDoctors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                HeaderSection(username: username),
                const SizedBox(height: 20),
                const BookingPromotionCard(),
                const SizedBox(height: 24),
                const SpecialitySection(),
                const SizedBox(height: 24),
                DoctorRecommendationSection(onRefresh: _loadDoctors),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
