class ProductModel {
  final String title;
  final String description;
  final String price;
  final String? categoryId;
  final String? docId;
  final String image;

  ProductModel({
    required this.title,
    required this.description,
    required this.price,
     this.categoryId,
     this.docId,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        title: json['title'] as String? ?? '',
        description: json["description"] as String? ?? '',
        price: json["price"] as String? ?? '',
        categoryId: json["category_id"] as String? ?? '',
        docId: json["doc_id"] as String? ?? '',
        image: json["image"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "doc_id": " ",
        "image": image
      };

  Map<String, dynamic> toUpdateJson() => {
        "title": title,
        "description": description,
        "price": price,
        "image": image
      };

  ProductModel copyWith({
    String? title,
    String? description,
    String? price,
    String? image,
  }) =>
      ProductModel(
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
      );

  static ProductModel initialValue = ProductModel(title: '', description: '', price: '', image: '', docId: '');
}
