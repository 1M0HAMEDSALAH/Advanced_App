import 'dart:developer';
import 'dart:io';

import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:advanced_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/themes/style.dart';
import '../../data/models/user_data.dart';
import '../../presentation/bloc/profile_bloc.dart';
import '../../presentation/bloc/profile_event.dart';
import '../../presentation/bloc/profile_state.dart';
import '../../service/user_data_service.dart';
import '../widgets/profile_action_buttons.dart';
import '../widgets/profile_bottom_actions.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_list.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late UserDataService _userDataService;
  UserData _userData = UserData.empty();

  @override
  void initState() {
    super.initState();
    _userDataService = UserDataService();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await _userDataService.loadUserData();
    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: _handleBlocStateChanges,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeader(
                    userData: _userData,
                    state: state,
                    onImageTap: _handleImageTap,
                  ),
                  Transform.translate(
                    offset: Offset(0.w, -50.h),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            spreadRadius: 0,
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfileActionButtons(
                            onMyAppointmentTap: _handleMyAppointmentTap,
                            onMedicalRecordsTap: _handleMedicalRecordsTap,
                          ),
                          SizedBox(height: 30.h),
                          ProfileMenuList(
                            onPersonalInfoTap: _handlePersonalInfoTap,
                            onTestDiagnosticTap: _handleTestDiagnosticTap,
                            onPaymentTap: _handlePaymentTap,
                          ),
                          SizedBox(height: 30.h),
                          ProfileBottomActions(
                            userId: _userData.userId,
                            onChangePasswordTap: _handleChangePasswordTap,
                            onLogoutTap: _handleLogout,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleBlocStateChanges(BuildContext context, ProfileState state) {
    if (state is ProfileImageUploading) {
    } else if (state is ProfileImageUploadSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture updated successfully'),
        ),
      );
      _loadUserData();
    } else if (state is ProfileImageUploadFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: ${state.error}')),
      );
    }
  }

  void _handleImageTap() {
    _showImagePickerDialog();
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    Text(
                      'اختر صورة الملف الشخصي',
                      style: TextStyles.font18WhiteSemiBold,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildImagePickerOption(
                            icon: Icons.camera_alt,
                            title: 'الكاميرا',
                            onTap: () => _pickImage(ImageSource.camera),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildImagePickerOption(
                            icon: Icons.photo_library,
                            title: 'المعرض',
                            onTap: () => _pickImage(ImageSource.gallery),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'إلغاء',
                        style: TextStyles.font16WhiteSemiBold.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.blue.shade700,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyles.font14BlackRegular.copyWith(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context); // Close the bottom sheet

    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        // Send the picked image to the ProfileBloc
        context.read<ProfileBloc>().add(
              UploadProfileImage(
                image: File(pickedFile.path),
                userId: _userData.partyId,
              ),
            );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في اختيار الصورة: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleMyAppointmentTap() {
    log("My Appointment tapped");
  }

  void _handleMedicalRecordsTap() {
    log("Medical records tapped");
  }

  void _handlePersonalInfoTap() {
    // context.pushNamed(Routes.personalInformationScreen);
    log("Personal Information tapped");
  }

  void _handleTestDiagnosticTap() {
    log("My Test & Diagnostic tapped");
  }

  void _handlePaymentTap() {
    log("Payment tapped");
  }

  void _handleChangePasswordTap() {
    context.pushNamedAndRemoveUntil(
      Routes.restpasswordscreen,
      arguments: _userData.userId,
      predicate: (Route<dynamic> route) => true,
    );
  }

  Future<void> _handleLogout() async {
    await _userDataService.logout();
    log("User logged out and preferences cleared successfully 🥰");

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم تسجيل الخروج بنجاح")),
      );
      context.pushNamedAndRemoveUntil(
        Routes.loginScreen,
        predicate: (Route<dynamic> route) => false,
      );
    }
  }
}
