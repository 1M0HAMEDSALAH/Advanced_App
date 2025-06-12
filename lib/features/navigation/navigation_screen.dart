import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/color.dart';
import '../../core/themes/image.dart';
import '../account/ui/screens/account_screen.dart';
import '../appointment/ui/screens/appointment_screen.dart';
import '../home/ui/screens/home_screen.dart';
import '../inbox/ui/screens/inbox_screen.dart';
import '../search/ui/screens/search_screen.dart';
import 'bloc/navigation_bloc.dart';
import 'bloc/navigation_event.dart';
import 'bloc/navigation_state.dart';
import 'nav_bar_items.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

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
            return const InboxScreen();
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
        // label: AppStrings.homeTitle,
      ),
      NavItem(
        iconPath: AppImages.inboxNavIcon,
        // label: AppStrings.orderTitle,
      ),
      NavItem(
        iconPath: AppImages.searchNavIcon,
        // label: AppStrings.favTitle,
      ),
      NavItem(
        iconPath: AppImages.appointmentNavIcon,
        // label: AppStrings.favTitle,
      ),
      NavItem(
        iconPath: AppImages.accNavIcon,
        // label: AppStrings.accountTitle,
      ),
    ];
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(int) onTap;
  final bool isLandscape;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    required this.isLandscape,
  }) : super(key: key);

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
                    _buildNavIcon(
                      items[index].iconPath,
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

  Widget _buildNavIcon(String iconPath, bool isSelected, double size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primary : Colors.grey,
          BlendMode.srcIn,
        ),
        child: Image.asset(
          iconPath,
          width: size,
          height: size,
        ),
      ),
    );
  }
}

class NavItem {
  final String iconPath;
  // final String label;

  NavItem({
    required this.iconPath,
    // required this.label,
  });
}
