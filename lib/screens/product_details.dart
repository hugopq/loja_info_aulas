import 'package:flutter/material.dart';
import 'package:loja_info/services/loja_service.dart';
import 'package:loja_info/widgets/details.dart';

class ProductDetails extends StatefulWidget {
  final LojaService service;

  const ProductDetails({super.key, required this.service});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Details(service: widget.service);
  }
}
