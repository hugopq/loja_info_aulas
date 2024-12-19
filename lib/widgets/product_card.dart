import 'package:flutter/material.dart';
import 'package:loja_info/data_objects/product.dart';
import 'package:loja_info/services/loja_service.dart';

class ProductCard extends StatelessWidget {
  final LojaService service;

  final Product product;
  final Function() showDetails;

  const ProductCard(
      {super.key,
      required this.product,
      required this.showDetails,
      required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListTile(
          title: Text(
            product.name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
          leading: Image.network("${service.baseUrl}${product.img}"),
          onTap: showDetails,
        ),
      ),
    );
  }
}
