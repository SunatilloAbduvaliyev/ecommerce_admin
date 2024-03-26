class CategoryModel{
  final String? docId;
  final String title;
  final String description;
  final String image;

  CategoryModel({
    this.docId,
    required this.title,
    required this.description,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      docId: json['id'] as String? ?? "",
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      image: json['image'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": "",
    'title': title,
    'description': description,
    'image': image,
  };

  Map<String, dynamic> toJsonForUpdate() => {
    'title': title,
    'description': description,
    'image': image,
  };


  CategoryModel copyWith({
    String? title,
    String? description,
    String? image,
  }) => CategoryModel(
    title: title ?? this.title,
    description: description ?? this.description,
    image: image ?? this.image,
  );

  static CategoryModel initialValue = CategoryModel(title: "", description: "", image: "");


}