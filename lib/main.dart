import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/config/size_config.dart';
import 'screens/main/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Admin Panel',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: bgColor,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.white),
                canvasColor: secondaryColor,
              ),
              home: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => MenuController(),
                  ),
                ],
                child: MainScreen(),
                //     AllFieldsV1(
                //   title: 'Form',
                // ),
              ),
            );
          },
        );
      },
    );
  }
}
