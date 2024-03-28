import 'package:admin_ecommerce/routes.dart';
import 'package:admin_ecommerce/screen/tab/category/view_model/category_view_model.dart';
import 'package:admin_ecommerce/screen/tab/products/view_model/product_view_model.dart';
import 'package:admin_ecommerce/screen/tab/tab_box_screen.dart';
import 'package:admin_ecommerce/utils/color/app_colors.dart';
import 'package:admin_ecommerce/view_model/image_view_model/image_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => ImageViewModel()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(376, 763),
      builder: (context, _){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.background,
              appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.background,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: Colors.transparent
                  )
              )
          ),
          home: const TabBoxScreen(),
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: AppRoute.generateRoute,
        );
      },
    );
  }
}