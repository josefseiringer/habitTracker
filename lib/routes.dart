
import 'package:get/get.dart';
import '../bindings.dart';
import '../pages/home_page.dart';
import '../pages/overview_page.dart';

class SampleRoutes {
  static List<GetPage<dynamic>> samplePages = [    
    GetPage(
        name: MyHomePage.namedRoute,
        page: ((() => const MyHomePage())),
        binding: SampleBindings()),
    GetPage(
        name: OverviewPage.namedRoute,
        page: ((() => const OverviewPage())),
        binding: SampleBindings())
  ];
}