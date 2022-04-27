
import 'package:app_login/models/models.dart';
import 'package:app_login/screens/screen.dart';
import 'package:app_login/services/services.dart';
import 'package:app_login/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

   
  const HomeScreen({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) { 

  final productsService= Provider.of<ProductsService>(context);
  final authService= Provider.of<AuthService>(context , listen: false);

  if( productsService.isLoading) return LoadingScreen();



  if(productsService.isLoading==true) return LoadingScreen();
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Productos')),
        leading: IconButton(
          icon:  const Icon(Icons.login_outlined),
          onPressed: (){
            authService.logunt();
            Navigator.pushReplacementNamed(context, 'login');
          },
        )
      ),
      body: ListView.builder(
        itemCount:productsService.products.length,
        itemBuilder: ( BuildContext context , int index) => GestureDetector(
          onTap: () { 
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
            },
          child:  ProductCard(
            product: productsService.products[index],
          )
          )  
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){

          productsService.selectedProduct = new Product(
            available: true, 
            name:'jjj', 
            price: 0
            );
          Navigator.pushNamed(context, 'product');

        }
      )
    );
  }
}