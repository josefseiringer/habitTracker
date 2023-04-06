import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../constants.dart';
import '../routes.dart';
import '../bindings.dart';
import '../pages/home_page.dart';

void main() async {
  SampleBindings().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(1100, 768));
    WindowManager.instance.setMaximumSize(const Size(1100, 768));
  }
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade700,
            centerTitle: true,
            foregroundColor: Colors.grey.shade300,
          ),
          textTheme: TextTheme(
            displayLarge: kMyTextStyle,
            bodyLarge: kMybodyTextStyleLarge,
            bodyMedium: kMybodyTextStyleMedium,
            bodySmall: kMybodyTextStyleSmall,
            labelMedium: kMyLabelFormFieldStyleMedium,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: MyHomePage.namedRoute,
        getPages: SampleRoutes.samplePages);
  }
}
