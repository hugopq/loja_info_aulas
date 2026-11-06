import 'package:loja_info/config/app_config.dart';
import 'package:loja_info/services/loja_service.dart';

class Product {
  int id;
  String name;
  String description;
  String img;
  double cost;
  int categoryId;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.img,
      required this.cost,
      required this.categoryId});

  String get imageUrl {
    String url = '';
    if (img.trim().isEmpty) {
      url = 'https://via.placeholder.com/150?text=Sem+Imagem';
    } else if (img.startsWith('http://') || img.startsWith('https://')) {
      url = img;
    } else {
      url = img.startsWith('/') ? img.substring(1) : img;
      url = "${AppConfig.baseUrl}/$url";
    }

    print(url);

    return url;
  }
}
