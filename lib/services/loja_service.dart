import 'dart:convert';
import 'package:loja_info/config/app_config.dart';
import 'package:loja_info/data_objects/product.dart';
import "package:http/http.dart" as http;

class LojaService {
  // Objetos para carregamento
  List<Product> products = [];
  int productId = 0;
  Product productToShow = Product(
      categoryId: 0,
      id: 0,
      name: "NO Product",
      description: "NO Product",
      cost: 0,
      img: "NO Product");

  // 1. MUDANÇA CRUCIAL: Usa HTTPS e o teu domínio real do Render
  // Substitui "teu-projeto" pelo nome real da tua app no Render

  String nextRoute = "/products";

  Future<void> getProducts() async {
    String address = "${AppConfig.baseUrl}/api/products";
    var url = Uri.parse(address);

    try {
      // 2. ADICIONADO: Timeout e tratamento de erros
      // O Render gratuito "adormece". Pode demorar 20-30s a acordar na 1ª requisição.
      var response = await http.get(url).timeout(
        const Duration(seconds: 35),
        onTimeout: () {
          throw Exception(
              "O servidor está a iniciar (Cold Start). Por favor, tenta novamente.");
        },
      );

      // 3. ADICIONADO: Verificar se o pedido foi bem-sucedido antes de fazer parse do JSON
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        products.clear();

        for (var element in data) {
          // 'var' é mais seguro que 'Map' aqui
          Product product = Product(
            // 4. ADICIONADO: Operador '??' para evitar crashes se a BD tiver valores nulos
            id: element['id'] ?? 0,
            name: element['Name'] ?? 'Sem nome',
            description: element['Description'] ?? 'Sem descrição',
            categoryId: element['category_id'] ?? 0,
            cost: (element['Cost'] ?? 0).toDouble(), // Garante que é um número
            img: element['img'] ?? '',
          );
          products.add(product);
        }
      } else {
        throw Exception("Erro do servidor: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao buscar produtos: $e");
      rethrow; // Lança o erro para a UI tratar (ex: mostrar mensagem ao utilizador)
    }
  }

  Future<void> getProductDetails() async {
    if (productId == 0) return;

    String address = "${AppConfig.baseUrl}/api/products/$productId";
    var url = Uri.parse(address);

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
        Map<String, dynamic> element = jsonDecode(response.body);

        productToShow = Product(
          id: element['id'] ?? 0,
          name: element['Name'] ?? 'Sem nome',
          description: element['Description'] ?? 'Sem descrição',
          categoryId: element['category_id'] ?? 0,
          cost: (element['Cost'] ?? 0).toDouble(),
          img: element['img'] ?? '',
        );
      } else {
        throw Exception(
            "Erro ao carregar detalhes: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao buscar detalhes: $e");
      rethrow;
    }
  }
}
