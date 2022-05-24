import 'package:admin/bloc/drawer_bloc/drawer_bloc_bloc.dart';
import 'package:admin/screens/main/components/sidebar_package.dart/sidebar_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../responsive.dart';

class DrawerListTile extends StatelessWidget {
  final String title, svgSrc;

  final VoidCallback press;
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sidebar.fromJson(
      tabs: [
        {
          'title': 'Cycle',
          'children': [
            {
              'title': 'Brand',
              'icon': "https://cdn-icons-png.flaticon.com/512/4549/4549880.png",
              'navigation': "form",
            },
          ],
          'icon': "https://cdn-icons-png.flaticon.com/512/4549/4549818.png",
          'navigation': "form",
        },
        {
          'title': 'Cycle',
          'children': [
            {
              'title': 'Brand',
              'icon': "https://cdn-icons-png.flaticon.com/512/4549/4549880.png",
              'navigation': "form",
              'children': [
                {
                  'title': 'Brand',
                  'icon':
                      "https://cdn-icons-png.flaticon.com/512/4549/4549880.png",
                  'navigation': "form",
                },
              ],
            },
          ],
          'icon': "https://cdn-icons-png.flaticon.com/512/4549/4549818.png",
          'navigation': "form",
        },
      ],
      onTabChanged: (string) {
        print(string);

        final drawerBloc = BlocProvider.of<DrawerBloc>(context);
        drawerBloc.add(NavigateTo(string));
        if (Responsive.isMobile(context)) {
          Navigator.pop(context);
        }
      },
    );

    //  Drawer(
    //   child: ListView(
    //     children: [
    //       DrawerHeader(
    //         child: ProfileCard(),
    //       ),
    //       DrawerListTile(
    //         title: "Dashboard",
    //         svgSrc: "assets/icons/menu_dashbord.svg",
    //         press: () {},
    //       ),
    //       DrawerListTile(
    //         title: "Transaction",
    //         svgSrc: "assets/icons/menu_tran.svg",
    //         press: () {},
    //       ),
    //       DrawerListTile(
    //         title: "Task",
    //         svgSrc: "assets/icons/menu_task.svg",
    //         press: () {},
    //       ),
    //       DrawerListTile(
    //         title: "Documents",
    //         svgSrc: "assets/icons/menu_doc.svg",
    //         press: () {},
    //       ),
    //       DrawerListTile(
    //         title: "Store",
    //         svgSrc: "assets/icons/menu_store.svg",
    //         press: () {},
    //       ),
    //       DrawerListTile(
    //         title: "Notification",
    //         svgSrc: "assets/icons/menu_notification.svg",
    //         press: () {},
    //       ),
    //       DrawerListTile(
    //         title: "Profile",
    //         svgSrc: "assets/icons/menu_profile.svg",
    //         press: () {},
    //       ),
    //       DrawerListTile(
    //         title: "Settings",
    //         svgSrc: "assets/icons/menu_setting.svg",
    //         press: () {},
    //       ),
    //     ],
    //   ),
    // );
  }
}
