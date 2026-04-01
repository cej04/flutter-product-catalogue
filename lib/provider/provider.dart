

import 'package:buylike/models/product_model.dart';
import 'package:buylike/services/api_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final _api = ApiService();

  List<ProductCategory> categories = [];
  List<Product> products = [];
   final List<Product> _fetched = [];
   bool loadingMore = false; 
  bool loading = false;
  String? error;

    bool hasMore = true;
  int _skip = 0;
  int _total = 0;
  String? _currentCategory;

  double? minPrice;
  double? maxPrice;
  double? minRating;
  String searchQuery = '';

  Future<void> loadCategories() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      categories = await _api.fetchCategories();
    } catch (e) {
      error = e.toString();
    }
    loading = false;
    notifyListeners();
  }

  Future<void> loadProducts({String? categorySlug}) async {
    _currentCategory = categorySlug;
    _skip = 0;
    _total = 0;
    hasMore = true;
    _fetched.clear();
    products = [];
    loading = true;
    error = null;
    notifyListeners();
    await _fetchNextPage();
    loading = false;
    notifyListeners();
  }

    Future<void> loadMore() async {
    if (loadingMore || !hasMore) return;
    loadingMore = true;
    notifyListeners();
    await _fetchNextPage();
    loadingMore = false;
    notifyListeners();
  }

    Future<void> _fetchNextPage() async {
    try {
      final result = await _api.fetchProducts(
        categorySlug: _currentCategory,
        skip: _skip,
      );
      final newItems = result['products'] as List<Product>;
      _total = result['total'] as int;
      _skip += newItems.length;
      _fetched.addAll(newItems);
      hasMore = _skip < _total;
      _applyFilters();
    } catch (e) {
      error = e.toString();
      hasMore = false;
    }
  }

  void setSearch(String q) {
    searchQuery = q;
    _applyFilters();
    notifyListeners();
  }

  void setFilters({double? min, double? max, double? rating}) {
    minPrice = min;
    maxPrice = max;
    minRating = rating;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    minPrice = null;
    maxPrice = null;
    minRating = null;
    searchQuery = '';
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    products = _fetched.where((p) {
      final matchSearch = searchQuery.isEmpty ||
          p.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchMin = minPrice == null || p.price >= minPrice!;
      final matchMax = maxPrice == null || p.price <= maxPrice!;
      final matchRating = minRating == null || p.rating >= minRating!;
      return matchSearch && matchMin && matchMax && matchRating;
    }).toList();
  }
}
