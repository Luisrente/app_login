import 'package:app_login/providers/login_form_provider.dart';
import 'package:app_login/ui/input_decorations.dart';
import 'package:app_login/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackGround(
        child: SingleChildScrollView(
          child: Column(
            children:  [
              const SizedBox(height: 250),
              CardContainer(
                child:  Column(
                  children: [
                     const SizedBox( height: 10),
                     Text('Login',style: Theme.of(context).textTheme.headline4),
                     const SizedBox( height: 30),
                     ChangeNotifierProvider(
                       create: (_) => LoginFormProvider( ),
                       child: _Login_Form()
                     ),
                  ]
                )
              ),
              const SizedBox(height:50),
              const Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height:50),
            ]
          )
        ) 
      ),
    );
  }
}

class _Login_Form extends StatelessWidget {

  const _Login_Form({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginForm= Provider.of<LoginFormProvider>(context);

    return Container(
      child:  Form(
        key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children:[
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hinText: 'jon.do@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => loginForm.email= value,
              validator: (value){
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = new RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                ? null
                : 'El valor ingredao no luce como un correo';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hinText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password= value,
              validator: (value) {
                return( value != null && value.length >= 6)
                  ? null
                  : 'La constraseña debede ser de 6 caracteres';
              },
            ),
            const SizedBox(height: 30),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: const EdgeInsets.symmetric( horizontal: 80, vertical: 15 ),
                child:  Text(
                   loginForm.isLoading 
                   ? 'Espere...'
                   : 'Ingresar', 
                style:  const TextStyle(color: Colors.white),
                )
              ),
              onPressed:  loginForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                if(!loginForm.isValidForm()) return ;
                loginForm.isLoading= true;
                await Future.delayed( const Duration(seconds: 2));
                //Validar si el login es correcto
                loginForm.isLoading= false;
                Navigator.pushReplacementNamed(context, 'home');
              }
            )       ]
        )
      )
      );
  }
}