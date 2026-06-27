import 'package:sarana_gdg_lp/domain/models/product.dart';

/// Domain model representing a local business or tourism service in Bolivia.
class Business {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final String communityStory;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String location;
  final String city;
  final String phone;
  final String whatsapp;
  final List<Product> products;
  final double latitude;
  final double longitude;

  const Business({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.communityStory,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.city,
    required this.phone,
    required this.whatsapp,
    required this.products,
    required this.latitude,
    required this.longitude,
  });
}
