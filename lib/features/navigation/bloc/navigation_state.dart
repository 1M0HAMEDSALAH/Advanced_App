import 'package:equatable/equatable.dart';
import '../nav_bar_items.dart';

class NavigationState extends Equatable {
  final NavbarItem selectedItem;
  final int selectedIndex;

  const NavigationState(this.selectedItem, this.selectedIndex);

  @override
  List<Object> get props => [selectedItem, selectedIndex];
}
