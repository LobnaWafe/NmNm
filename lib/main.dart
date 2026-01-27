import 'package:flutter/material.dart';
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(const SampleFace());

}

class SampleFace extends StatelessWidget {
  const SampleFace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
     routerConfig: AppRouter.router,
     theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}