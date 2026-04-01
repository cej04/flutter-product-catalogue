import 'dart:convert';
import 'package:buylike/models/product_model.dart';
import 'package:http/http.dart' as http;

const int kPageSize = 10;

//service class to handle API calls for fetching categories and products with pagination support  

class ApiService {
  static const _baseurl = 'https://dummyjson.com';

  Future<List<ProductCategory>> fetchCategories() async {
    final categoryResponse = await http.get(Uri.parse('$_baseurl/products/categories'));
    if (categoryResponse.statusCode == 200) {
      final List data = jsonDecode(categoryResponse.body);
      return data.map((e) => ProductCategory.fromJson(e)).toList();
    }
    throw Exception('Failed to load categories');
  }

  Future<Map<String, dynamic>> fetchProducts({
    String? categorySlug,
    int skip = 0,
    int limit = kPageSize,
  }) async {
    final base = categorySlug != null
        ? '$_baseurl/products/category/$categorySlug'
        : '$_baseurl/products';
    final url = '$base?limit=$limit&skip=$skip';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return {
        'products': (data['products'] as List).map((e) => Product.fromJson(e)).toList(),
        'total': data['total'] as int,
      };
    }
    throw Exception('Failed to load products');
  }
}