import 'package:app_login/screens/screen.dart';
import 'package:app_login/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() => runApp( const AppState());

class AppState extends StatelessWidget {
  const  AppState({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => ProductsService(), lazy: true),
        ChangeNotifierProvider( create: ( _ ) => AuthService())
      ],
       child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
       'checking'  : (_) => const CheckAuthScreen(),
       'home'      : (_) => const HomeScreen(),
       'login'     : (_) => const LoginScreen(),
       'product'   : (_) => const ProductScreen(),
       'register'  : (_) => const RegisterScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme:  const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
      );
  }
}