import 'package:flutter/material.dart';
import 'package:loja_info/config/app_config.dart';
import 'package:loja_info/screens/loading.dart';
import 'package:loja_info/screens/product_details.dart';
import 'package:loja_info/screens/products.dart';
import 'package:loja_info/services/loja_service.dart';

void main() {
  LojaService service = LojaService();
  AppConfig.initialize(apiBaseUrl: "https://loja-info.onrender.com");

  runApp(MaterialApp(
    initialRoute: '/loadingProducts',
    routes: {
      '/loadingProducts': (context) {
        service.nextRoute = "/products";
        return Loading(service: service);
      },
      '/products': (context) => Products(service: service),
      '/loadingDetails': (context) {
        service.nextRoute = "/details";
        return Loading(service: service);
      },
      '/details': (context) => ProductDetails(service: service),
    },
  ));
}
