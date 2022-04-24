
import 'package:app_login/models/models.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState>formKey= new GlobalKey<FormState> ();

  Product product;

  ProductFormProvider( this.product);
  updateAvailability(bool value){
    print(value);
    this.product.available=value;
    notifyListeners();

  }

  bool isValidForm(){
     return formKey.currentState?.validate() ?? false;
  }
}