import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:privacy_maid_flutter/screens/Hiredmaid_page.dart';
import 'package:privacy_maid_flutter/screens/Home_page.dart';
import 'package:privacy_maid_flutter/screens/Setting_page.dart';

class NavigationMenuBar extends StatefulWidget {
  final String? selectPage;
  const NavigationMenuBar({Key? key, this.selectPage}) : super(key: key);

  @override
  State<NavigationMenuBar> createState() => _NavigationMenuBarState();
}

class _NavigationMenuBarState extends State<NavigationMenuBar> {
  PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorSecondary: CupertinoColors.black,
        icon: Icon(Icons.home_filled),
        title: ("หน้าหลัก"),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
          inactiveColorSecondary: CupertinoColors.black,
          icon: Icon(Icons.add),
          title: ("แม่บ้าน"),
          activeColorPrimary: Colors.green,
          inactiveColorPrimary: Colors.blueGrey),
      PersistentBottomNavBarItem(
          inactiveColorSecondary: CupertinoColors.black,
          icon: Icon(Icons.person_2_rounded),
          title: ("ตั้งค่า"),
          activeColorPrimary: Colors.green,
          inactiveColorPrimary: Colors.blueGrey),

    ];
  }

  List<Widget> _buildScreens() {
    return [HomePage(), HiredMaidPage(), SettingsPage()];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      hideNavigationBar: false,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.white],
          )),

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.once,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 250),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}