import 'dart:convert';
import 'package:loja_info/data_objects/product.dart';
import "package:http/http.dart" as http;

class LojaService {
  //objetos para carregamento
  List<Product> products = [];
  int productId = 0;
  Product productToShow = Product(
      categoryId: 0,
      id: 0,
      name: "NO Product",
      description: "NO Product",
      cost: 0,
      img: "NO Product");

  //elementos da API
  // final String baseUrl = "http://127.0.0.1:8000";
  final String baseUrl = "https://loja-info.onrender.com";
  String nextRoute = "/products";

  Future<void> getProducts() async {
    String apiUrl = "$baseUrl/api";
    String address = "$apiUrl/products";
    var url = Uri.parse(address);

    try {
      // 2. ADICIONADO: Timeout e tratamento de erros
      // O Render gratuito "adormece". Pode demorar 20-30s a acordar na 1ª requisição.
      var response = await http.get(url).timeout(
        const Duration(seconds: 35), 
        onTimeout: () {
          throw Exception("O servidor está a iniciar (Cold Start). Por favor, tenta novamente.");
        },
      );

      // 3. ADICIONADO: Verificar se o pedido foi bem-sucedido antes de fazer parse do JSON
      if (response.statusCode == 200) 
      {
        List<dynamic> data = jsonDecode(response.body);

        products.clear();

        for (Map element in data) {
          Product product = Product(
            id: element['id'],
            name: element['Name'],
            description: element['Description'],
            categoryId: element['category_id'],
            cost: element['Cost'],
            img: element['img'],
          );

          products.add(product);
        }
      }
    }
  }

  Future<void> getProductDetails() async {
    //sai da função se não existir produto para pesquisar
    if (productId == 0) return;

    String apiUrl = "$baseUrl/api";
    String address = "$apiUrl/products/$productId";
    var url = Uri.parse(address);

    // var response = await http.get(url);
    try {
          var response = await http.get(url).timeout(
            const Duration(seconds: 35),
            onTimeout: () {
              throw Exception("O servidor está a iniciar. Tenta novamente.");
            },
          );

          if (response.statusCode == 200) {
            // Nota: Se a tua API retornar um objeto único, isto funciona. 
            // Se retornar {"success": true, "data": {...}}, terás de usar jsonDecode(response.body)['data']
            
        Map element = jsonDecode(response.body);

        productToShow = Product(
          id: element['id'],
          name: element['Name'],
          description: element['Description'],
          categoryId: element['category_id'],
          cost: element['Cost'],
          img: element['img'],
        );
      }
    }
  }
}
