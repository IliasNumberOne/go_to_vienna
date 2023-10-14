class Category {
  final int id;
  final String name;
  final String asset;

  const Category({
    required this.id,
    required this.name,
    required this.asset,
  });
}

class Place {
  final int id;
  final String title;
  final String text;
  final String asset;
  final bool isPremium;
  final int category;

  const Place({
    required this.id,
    required this.title,
    required this.text,
    required this.asset,
    required this.isPremium,
    required this.category,
  });
}


