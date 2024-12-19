import 'package:flutter/material.dart';
import 'package:loja_info/services/loja_service.dart';

class Details extends StatelessWidget {
  final LojaService service;

  const Details({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loja Info"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Image.network(
            "${service.baseUrl}${service.productToShow.img}",
            height: 400,
          ),
          Text(
            service.productToShow.name,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            service.productToShow.description,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            "€ ${service.productToShow.cost}",
            style: const TextStyle(
              fontSize: 28,
              color: Colors.yellowAccent,
            ),
          ),
        ],
      ),
    );
  }
}
