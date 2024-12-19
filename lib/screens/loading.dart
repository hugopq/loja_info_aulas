import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loja_info/services/loja_service.dart';

class Loading extends StatefulWidget {
  final LojaService service;

  const Loading({super.key, required this.service});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> setupService() async {
    await widget.service.getProducts();
    await widget.service.getProductDetails();

    Navigator.pushReplacementNamed(context, widget.service.nextRoute);
  }

  @override
  void initState() {
    super.initState();
    setupService();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitDancingSquare(
        color: Colors.green,
      ),
    );
  }
}
