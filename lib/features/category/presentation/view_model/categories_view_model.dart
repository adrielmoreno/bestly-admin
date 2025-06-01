import 'package:flutter/material.dart';

import '../../data/repositories/categories_repository.dart';
import '../../domain/entities/category_response.dart';

class CategoriesViewModel extends ChangeNotifier {
  final CategoriesRepository _categoriesRepository;
  CategoriesViewModel(this._categoriesRepository);

  List<CategoryResponse> categories = [];
  bool isLoading = false;

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    categories = await _categoriesRepository.getAll();

    isLoading = false;
    notifyListeners();
  }

  Future<void> newCategory(String name) async {
    final category = await _categoriesRepository.newCategory(name);

    if (category != null) {
      _addNewCategory(category);
    }
  }

  Future<void> updateCategory(CategoryResponse category) async {
    await _categoriesRepository.updateCategory(category);

    final index = categories.indexWhere((value) => value.id == category.id);

    categories[index] = category;
    notifyListeners();
  }

  Future<void> deleteCategory(String categoryId) async {
    await _categoriesRepository.deleteCategory(categoryId);

    categories.removeWhere((value) => value.id == categoryId);
    notifyListeners();
  }

  void _addNewCategory(CategoryResponse category) {
    categories.add(category);
    notifyListeners();
  }
}
