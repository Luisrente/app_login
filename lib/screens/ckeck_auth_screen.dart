
import 'package:app_login/screens/screen.dart';
import 'package:app_login/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService= Provider.of<AuthService>(context, listen: false);

    return  Scaffold(
      body: Center(
         child: FutureBuilder(
           future: authService.readToken(),
           builder: (BuildContext context, AsyncSnapshot<String> snapshot){

             if(!snapshot.hasData)
              return const Text('Espere');

             if ( snapshot == ''){
              Future.microtask((){
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: ( _ , __ , ___) => const LoginScreen(),
                  transitionDuration: const Duration( seconds: 0)
                ));
                //Navigator.of(context).pushReplacementNamed('home');
              });
             }else{
                Future.microtask((){
                  Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_,__,___) => const LoginScreen(),
                    transitionDuration: const Duration( seconds: 0)
                  )
                );
                //Navigator.of(context).pushReplacementNamed('home');
              });
             }
              return Container();
           },
           ),
      ),
    );
  }
}