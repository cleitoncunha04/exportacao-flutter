
import '../data/repository/repository.dart';

class Product {
  final String productID;
  final String productDescription;
  final String productStUnit;

  Product({
    required this.productID,
    required this.productDescription,
    required this.productStUnit,
  });

  static Repository<Product>? repository;

  static Future<List<Product>> getAll() async {
    if(repository != null)
    {
      return await repository!.getAll();
    }
    else
    {
      throw Exception('Repository don\'t ...');
    }
  }
  Future<Product> create() async {
    return await repository!.create(this);
  }

  update() async {
    await repository!.update(this);
  }

  delete() async {
    await repository!.delete(this);
  }
}
