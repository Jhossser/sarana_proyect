import 'package:sarana_gdg_lp/data/services/business_service.dart';
import 'package:sarana_gdg_lp/domain/models/business.dart';
import 'package:sarana_gdg_lp/domain/models/category.dart';

/// Repository that provides access to business and category data.
/// Acts as the single source of truth for all business-related domain models.
class BusinessRepository {
  BusinessRepository({required BusinessService businessService})
      : _service = businessService;

  final BusinessService _service;

  // In-memory cache to avoid repeated data construction
  List<Business>? _cachedBusinesses;
  List<Category>? _cachedCategories;

  /// Returns all categories, using cache after first load.
  List<Category> getCategories() {
    _cachedCategories ??= _service.fetchCategories();
    return _cachedCategories!;
  }

  /// Returns all businesses, using cache after first load.
  List<Business> getAllBusinesses() {
    _cachedBusinesses ??= _service.fetchBusinesses();
    return _cachedBusinesses!;
  }

  /// Returns businesses filtered by [categoryId].
  List<Business> getBusinessesByCategory(String categoryId) {
    return getAllBusinesses()
        .where((b) => b.categoryId == categoryId)
        .toList();
  }

  /// Returns a single business by its [id], or null if not found.
  Business? getBusinessById(String id) {
    try {
      return getAllBusinesses().firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}
