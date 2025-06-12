import 'package:equatable/equatable.dart';
import '../nav_bar_items.dart';


abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class ChangeNavItemEvent extends NavigationEvent {
  final NavbarItem navbarItem;

  const ChangeNavItemEvent(this.navbarItem);

  @override
  List<Object> get props => [navbarItem];
}
