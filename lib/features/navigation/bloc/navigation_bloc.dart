import 'package:bloc/bloc.dart';
import '../nav_bar_items.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(NavbarItem.home, 0)) {
    on<ChangeNavItemEvent>(_onChangeNavItemEvent);
  }

  void _onChangeNavItemEvent(
      ChangeNavItemEvent event, Emitter<NavigationState> emit) {
    final NavbarItem newItem = event.navbarItem;
    int index = 0;

    switch (newItem) {
      case NavbarItem.home:
        index = 0;
        break;
      case NavbarItem.indox:
        index = 1;
        break;
      case NavbarItem.search:
        index = 2;
        break;
      case NavbarItem.appointment:
        index = 3;
        break;
      case NavbarItem.account:
        index = 4;
        break;
      default:
        index = 0;
    }

    emit(NavigationState(newItem, index));
  }
}
