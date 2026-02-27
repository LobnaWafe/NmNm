import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(
    DevicePreview(
      enabled: false,
      builder:  (context)=> const SampleFace())
   
    );

}

class SampleFace extends StatelessWidget {
  const SampleFace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
     routerConfig: AppRouter.router,
     theme: ThemeData(scaffoldBackgroundColor: Colors.white,
     appBarTheme: AppBarTheme(
    // elevation: 0,
      backgroundColor: kPrimaryColorB,
     surfaceTintColor: Colors.transparent, // مهم لأندرويد 12+
     )
     ),
    );
  }
}