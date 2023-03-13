class DishDataModel {
  final String id;
  final String created;
  final String changed;
  late final String category;
  late final String name;
  late final String description;
  late final String prepTime;
  late final String availTime;
  late final bool inStock;
  late final double price;
  late final String image;
  late final int availQuntity;

  DishDataModel(
      {required this.id,
      required this.changed,
      required this.created,
      required this.category,
      required this.name,
      required this.description,
      required this.prepTime,
      required this.availTime,
      required this.inStock,
      required this.price,
      required this.availQuntity,
      required this.image});

  factory DishDataModel.fromJson(Map<String, dynamic> json) {
    return DishDataModel(
        id: json['id'],
        created: json['Created'],
        changed: json['Changed'] == null ? "" : json['Changed'],
        category: json['category'],
        name: json['name'],
        description: json['description'],
        prepTime: json['prepTime'],
        availTime: json['availTime'],
        inStock: json['inStock'] == 'true' ? true : false,
        price: double.parse(json['price']),
        availQuntity: json['availQuntity'] == null || json['availQuntity'] == ""
            ? 10
            : int.parse(json['availQuntity']),
        image: json['image'] == null ? "" : json['image']);
  }
}

class DishData {
  String category;
  String name;
  String description;
  String prepTime;
  String availTime;
  bool inStock;
  double price;
  String image;
  int availQuntity;

  DishData(this.category, this.name, this.description, this.prepTime,
      this.availTime, this.inStock, this.image, this.availQuntity, this.price);

  Map<String, dynamic> toJson() => {
        'category': category,
        'name': name,
        'description': description,
        'prepTime': prepTime,
        'availTime': availTime,
        'inStock': inStock,
        'price': price,
        'availQuntity': availQuntity,
        'image': image,
      };
}
