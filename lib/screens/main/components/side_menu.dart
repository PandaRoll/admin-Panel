import 'package:admin/screens/main/components/sidebar_package.dart/sidebar_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sidebar.fromJson(
      tabs: [
        {
          'title': 'Chapter A',
          'children': [
            {'title': 'Chapter A1'},
            {'title': 'Chapter A2'},
            {'title': 'Chapter A3'},
            {
              'title': 'Chapter A4',
              'children': [
                {'title': 'Chapter A41'},
                {'title': 'Chapter A42'},
                {'title': 'Chapter A43'},
              ],
            },
          ],
          'link': "",
        },
        {
          'title': 'Chapter B',
          'children': [
            {'title': 'Chapter B1'},
            {
              'title': 'Chapter B2',
              'children': [
                {'title': 'Chapter B2a'},
                {'title': 'Chapter B2b'},
              ],
            },
          ],
        },
        {'title': 'Chapter C'},
      ],
      onTabChanged: (string) {
        print(string);
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

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

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
