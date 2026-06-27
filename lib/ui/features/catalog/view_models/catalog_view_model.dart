import 'package:flutter/material.dart';
import 'package:sarana_gdg_lp/data/repositories/business_repository.dart';
import 'package:sarana_gdg_lp/domain/models/business.dart';
import 'package:sarana_gdg_lp/domain/models/category.dart';

/// ViewModel for the CatalogScreen.
/// Manages category selection and provides filtered business lists.
class CatalogViewModel extends ChangeNotifier {
  CatalogViewModel({required BusinessRepository businessRepository})
      : _repository = businessRepository {
    _categories = _repository.getCategories();
    _selectedCategoryId = _categories.first.id;
  }

  final BusinessRepository _repository;

  late List<Category> _categories;
  late String _selectedCategoryId;

  List<Category> get categories => _categories;
  String get selectedCategoryId => _selectedCategoryId;

  /// Returns businesses for all categories as a map categoryId → businesses.
  Map<String, List<Business>> get businessesByCategory {
    return {
      for (final cat in _categories)
        cat.id: _repository.getBusinessesByCategory(cat.id),
    };
  }

  /// Changes the selected category chip.
  void selectCategory(String categoryId) {
    if (_selectedCategoryId == categoryId) return;
    _selectedCategoryId = categoryId;
    notifyListeners();
  }
}
