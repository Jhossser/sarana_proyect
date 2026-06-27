/// Domain model representing a business category.
class Category {
  final String id;
  final String name;
  final String emoji;
  final String description;

  const Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
  });
}
