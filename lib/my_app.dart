import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app_router.dart';
import 'app/di/di.dart';
import 'app/style.dart';
import 'cubit/app_cubit.dart';

class MyApp extends StatelessWidget {
  static late bool isDark;
  static late BuildContext appContext;
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AppCubit>(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, local) {
          var cubit = context.read<AppCubit>();
          isDark = cubit.isDark;
          return MaterialApp(
            onGenerateTitle: (context) {
              appContext = context;
              return "";
            },
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(cubit.isDark),
            darkTheme: Styles.themeData(cubit.isDark),
            themeMode: ThemeMode.dark,
            onGenerateRoute: AppRouter.generatedRoute,
            initialRoute: AppRouter.splashScreen,
          );
        },
      ),
    );
  }
}
