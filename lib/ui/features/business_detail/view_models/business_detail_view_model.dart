import 'package:flutter/material.dart';
import 'package:sarana_gdg_lp/data/repositories/business_repository.dart';
import 'package:sarana_gdg_lp/domain/models/business.dart';

/// ViewModel for the BusinessDetailScreen.
/// Loads a specific business by ID from the repository.
class BusinessDetailViewModel extends ChangeNotifier {
  BusinessDetailViewModel({
    required BusinessRepository businessRepository,
    required String businessId,
  })  : _repository = businessRepository,
        _businessId = businessId {
    _load();
  }

  final BusinessRepository _repository;
  final String _businessId;

  Business? _business;
  bool _isLoading = true;

  Business? get business => _business;
  bool get isLoading => _isLoading;

  void _load() {
    _business = _repository.getBusinessById(_businessId);
    _isLoading = false;
    notifyListeners();
  }
}
