import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  final ApiService _apiService = ApiService();
  late Future<List<Product>> _wishlistFuture;

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  void _loadWishlist() {
    _wishlistFuture = _apiService.fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: FutureBuilder<List<Product>>(
                future: _apiService.fetchWishlist(),
                builder: (context, snapshot) {
                  int count = 0;

                  if (snapshot.hasData) count = snapshot.data?.length ?? 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My Wishlist",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
                      ),
                      Text(
                        "$count items",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 2. Wishlist Items List
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _wishlistFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF1A1A1A)));
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildEmptyState();
                  }

                  final products = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildWishlistItem(product);
                    }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistItem(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 15),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A1A1A)),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${product.price}",
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
          // Remove Button
          GestureDetector(
            onTap: () async {
              bool success = await _apiService.removeFromWishlist(product.id);
              if (success) {
                _loadWishlist();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Item removed from wishlist")),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "Your wishlist is empty",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            "Start adding your favorite items!",
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}