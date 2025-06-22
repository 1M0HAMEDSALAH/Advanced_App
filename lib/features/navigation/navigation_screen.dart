// navigation_screen.dart (or where your NavigationScreen is located)
import 'dart:async'; // Import for Timer

import 'package:advanced_app/core/networking/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

import '../../core/networking/api_service.dart';
import '../../core/themes/color.dart';
import '../../core/themes/image.dart';
import '../account/ui/screens/account_screen.dart';
import '../appointment/ui/screens/appointment_screen.dart';
import '../home/ui/screens/home_screen.dart';
import '../inbox/data/repositories/chat_repository.dart';
import '../inbox/presentation/bloc/chat_bloc.dart';
import '../inbox/ui/screens/inbox_screen.dart';
import '../search/ui/screens/search_screen.dart';
import 'bloc/navigation_bloc.dart';
import 'bloc/navigation_event.dart';
import 'bloc/navigation_state.dart';
import 'nav_bar_items.dart';

class NavigationScreen extends StatefulWidget {
  // Change to StatefulWidget
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  String _profileImageUrl = ''; // State variable to hold the profile image URL
  Timer? _imageRefreshTimer; // Timer for periodic image refresh

  @override
  void initState() {
    super.initState();
    _loadProfileImage(); // Load the profile image when the screen initializes
    _startImageRefreshTimer(); // Start the periodic timer
  }

  @override
  void dispose() {
    _imageRefreshTimer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final imageUrl = prefs.getString("Image") ?? "";

      // Only update state if the image URL has changed or if it's the first load
      if (_profileImageUrl != imageUrl) {
        setState(() {
          _profileImageUrl = imageUrl;
        });
      }
    } catch (e) {
      // Handle any errors in loading the image
      print('Error loading profile image: $e');
    }
  }

  void _startImageRefreshTimer() {
    _imageRefreshTimer = Timer.periodic(
      const Duration(seconds: 10), // Refresh every 10 seconds
      (timer) {
        _loadProfileImage(); // Reload the profile image
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state.selectedItem == NavbarItem.home) {
            return const HomeScreen();
          } else if (state.selectedItem == NavbarItem.indox) {
            return BlocProvider(
              create: (context) => ChatBloc(ChatRepository(ApiService())),
              child: const InboxScreen(),
            );
          } else if (state.selectedItem == NavbarItem.search) {
            return const SearchScreen();
          } else if (state.selectedItem == NavbarItem.appointment) {
            return const AppointmentScreen();
          } else if (state.selectedItem == NavbarItem.account) {
            return const AccountScreen();
          }
          return Container();
        },
      ),
      // Use a conditional layout for landscape mode
      bottomNavigationBar: isLandscape
          ? _buildLandscapeNavigation(context)
          : _buildPortraitNavigation(context),
    );
  }

  // Portrait mode uses the standard bottom navigation bar
  Widget _buildPortraitNavigation(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: CustomBottomNavBar(
              currentIndex: state.selectedIndex,
              onTap: (index) => _handleNavTap(context, index),
              items: _getNavItems(),
              isLandscape: false,
              profileImageUrl: _profileImageUrl, // Pass the image URL
            ),
          ),
        );
      },
    );
  }

  // Landscape mode uses a side navigation bar
  Widget _buildLandscapeNavigation(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          height: 60, // Fixed smaller height for landscape
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: CustomBottomNavBar(
              currentIndex: state.selectedIndex,
              onTap: (index) => _handleNavTap(context, index),
              items: _getNavItems(),
              isLandscape: true,
              profileImageUrl: _profileImageUrl, // Pass the image URL
            ),
          ),
        );
      },
    );
  }

  // Centralized navigation handling
  void _handleNavTap(BuildContext context, int index) {
    if (index == 0) {
      BlocProvider.of<NavigationBloc>(context)
          .add(const ChangeNavItemEvent(NavbarItem.home));
    } else if (index == 1) {
      BlocProvider.of<NavigationBloc>(context)
          .add(const ChangeNavItemEvent(NavbarItem.indox));
    } else if (index == 2) {
      BlocProvider.of<NavigationBloc>(context)
          .add(const ChangeNavItemEvent(NavbarItem.search));
    } else if (index == 3) {
      BlocProvider.of<NavigationBloc>(context)
          .add(const ChangeNavItemEvent(NavbarItem.appointment));
    } else if (index == 4) {
      BlocProvider.of<NavigationBloc>(context)
          .add(const ChangeNavItemEvent(NavbarItem.account));
    }
  }

  // Navigation items
  List<NavItem> _getNavItems() {
    return [
      NavItem(
        iconPath: AppImages.homeNavIcon,
        itemType: NavItemType.icon, // Explicitly set type for clarity
      ),
      NavItem(
        iconPath: AppImages.inboxNavIcon,
        itemType: NavItemType.icon,
      ),
      NavItem(
        iconPath: AppImages.searchNavIcon,
        itemType: NavItemType.icon,
      ),
      NavItem(
        iconPath: AppImages.appointmentNavIcon,
        itemType: NavItemType.icon,
      ),
      NavItem(
        iconPath: AppImages.accNavIcon, // This will be the account icon
        itemType: NavItemType.account, // Mark this as the account item
      ),
    ];
  }
}

enum NavItemType { icon, account } // Define an enum for item type

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(int) onTap;
  final bool isLandscape;
  final String profileImageUrl; // New parameter for profile image URL

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    required this.isLandscape,
    required this.profileImageUrl, // Require the new parameter
  });

  @override
  Widget build(BuildContext context) {
    // Calculate adaptive dimensions based on orientation
    final double iconSize = isLandscape ? 18.0 : 23.22.sp;
    final double verticalPadding = isLandscape ? 4.0 : 8.sp;
    final double navBarHeight = isLandscape ? 60.0 : 80.sp;

    return SizedBox(
      height: navBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              splashColor: AppColors.primary,
              highlightColor: AppColors.primary,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                decoration: BoxDecoration(
                  border: index == currentIndex
                      ? Border(
                          top: BorderSide(
                            color: AppColors.textgrey,
                            width: isLandscape ? 1.5 : 2.sp,
                          ),
                        )
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavItemWidget(
                      items[index],
                      index == currentIndex,
                      iconSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemWidget(NavItem item, bool isSelected, double size) {
    if (item.itemType == NavItemType.account) {
      return CircleAvatar(
        radius: size / 2, // Adjust radius based on iconSize
        backgroundColor: Colors.white, // Background for the avatar
        child: CircleAvatar(
          radius: size / 2 - 2, // Slightly smaller for border effect
          backgroundImage: profileImageUrl.isNotEmpty
              ? NetworkImage("${EndPoints.baseUrlImages}$profileImageUrl")
              : const AssetImage(AppImages.defaultProfile) as ImageProvider,
          // Add error handling for network images
          onBackgroundImageError: profileImageUrl.isNotEmpty
              ? (exception, stackTrace) {
                  print('Error loading profile image: $exception');
                }
              : null,
        ),
      );
    } else {
      // Original icon building logic
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primary : Colors.grey,
          BlendMode.srcIn,
        ),
        child: Image.asset(
          item.iconPath,
          width: size,
          height: size,
        ),
      );
    }
  }
}

class NavItem {
  final String iconPath;
  final NavItemType itemType;

  NavItem({
    required this.iconPath,
    this.itemType = NavItemType.icon,
  });
}
