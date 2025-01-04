import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loca_app/users/fragments/favorites_fragment_screen.dart';
import 'package:loca_app/users/fragments/home_fragment_screen.dart';
import 'package:loca_app/users/fragments/order_fragment_screen.dart';
import 'package:loca_app/users/fragments/profile_fragment_screen.dart';
import 'package:loca_app/users/userPreferences/current_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardOfFragments extends StatelessWidget
{
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _fragmentScreens =
      [
        HomeFragmentScreen(),
        FavoritesFragmentScreen(),
        OrderFragmentScreen(),
        ProfileFragmentScreen(),
      ];

  List _navigationButtonsProperties =
      [
        {
          "active_icon": Icons.home,
          "non_active_icon": Icons.home_outlined,
          "label": "Home",
        },
        {
          "active_icon": Icons.favorite,
          "non_active_icon": Icons.favorite_border,
          "label": "Favorites",
        },
        {
          "active_icon": FontAwesomeIcons.boxOpen,
          "non_active_icon": FontAwesomeIcons.box,
          "label": "Orders",
        },
        {
          "active_icon": Icons.person,
          "non_active_icon": Icons.percent_outlined,
          "label": "Profile",
        },
      ];

  RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context)
  {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState)
      {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Obx(
                ()=> _fragmentScreens[_indexNumber.value]
            ),
          ),
          bottomNavigationBar: Obx(
              ()=> BottomNavigationBar(
                currentIndex: _indexNumber.value,
                onTap: (value)
                {
                  _indexNumber.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white24,
                items: List.generate(4, (index)
                {
                  var navBtnProperty = _navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"],
                  );
                }),
              ),
          ),
        );
      },
    );
  }
}
