import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = "http://10.242.21.239:5000/api";

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> data = body['data'];
        return data
            .map(
              (item) => Product(
                id: item['_id'],
                name: item['name'],
                description: item['description'],
                price: item['price'].toDouble(),
                imageUrl: item['imageUrl'],
              ),
            )
            .toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Product> fetchProductById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        var item = body['data'];
        return Product(
          id: item['_id'],
          name: item['name'],
          description: item['description'],
          price: item['price'].toDouble(),
          imageUrl: item['imageUrl'],
        );
      } else {
        throw Exception("Product not found");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<bool> createProduct(
    String name,
    double price,
    String description,
    String category,
    File imageFile,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/products'),
      );

      request.fields['name'] = name;
      request.fields['price'] = price.toString();
      request.fields['description'] = description;
      request.fields['category'] = category;

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      var streamedResponse = await request.send();
      return streamedResponse.statusCode == 201;
    } catch (e) {
      print("Error creating product: $e");
      return false;
    }
  }

  Future<bool> updateProduct(
    String id,
    String name,
    double price,
    String description,
    String category, {
    File? imageFile,
  }) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/products/$id'),
      );

      request.fields['name'] = name;
      request.fields['price'] = price.toString();
      request.fields['description'] = description;
      request.fields['category'] = category;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      }

      var streamedResponse = await request.send();
      return streamedResponse.statusCode == 200;
    } catch (e) {
      print("Error updating product: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // ================= WISHLIST ENDPOINTS =================

  Future<List<Product>> fetchWishlist() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/wishlist'));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> data = body['data'];
        return data.map((item) {
          var productData = item['productId'];
          return Product(
            id: productData['_id'],
            name: productData['name'],
            description: productData['description'],
            price: productData['price'].toDouble(),
            imageUrl: productData['imageUrl'],
          );
        }).toList();
      } else {
        throw Exception("Failed to load wishlist");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<bool> addToWishlist(String productId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/wishlist'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"productId": productId}),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromWishlist(String wishlistId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/wishlist/$wishlistId'),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
