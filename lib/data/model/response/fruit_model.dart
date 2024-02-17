/// name : "Persimmon"
/// id : 52
/// family : "Ebenaceae"
/// order : "Rosales"
/// genus : "Diospyros"
/// image : "https://fruitstorage.blob.core.windows.net/images/persimmon.png"
/// nutritions : {"calories":81,"fat":0,"sugar":18,"carbohydrates":18,"protein":0}

class FruitModel {
  FruitModel({
      this.name, 
      this.id, 
      this.family, 
      this.order, 
      this.genus, 
      this.image,
      this.quantity,
      this.nutritions,});

  FruitModel.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    family = json['family'];
    order = json['order'];
    genus = json['genus'];
    image = json['image'];
    quantity = json['quantity'];
    nutritions = json['nutritions'] != null ? Nutritions.fromJson(json['nutritions']) : null;
  }
  String? name;
  num? id;
  String? family;
  String? order;
  String? genus;
  String? image;
  int? quantity;
  Nutritions? nutritions;

FruitModel copyWith({  String? name,
  num? id,
  String? family,
  String? order,
  String? genus,
  String? image,
  int? quantity,
  Nutritions? nutritions,
}) => FruitModel(  name: name ?? this.name,
  id: id ?? this.id,
  family: family ?? this.family,
  order: order ?? this.order,
  genus: genus ?? this.genus,
  image: image ?? this.image,
  quantity: quantity ?? this.quantity,
  nutritions: nutritions ?? this.nutritions,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['family'] = family;
    map['order'] = order;
    map['genus'] = genus;
    map['image'] = image;
    map['quantity'] = quantity;
    if (nutritions != null) {
      map['nutritions'] = nutritions?.toJson();
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is FruitModel &&
              other.id == this.id &&
              other.name == this.name);

}

/// calories : 81
/// fat : 0
/// sugar : 18
/// carbohydrates : 18
/// protein : 0

class Nutritions {
  Nutritions({
      this.calories, 
      this.fat, 
      this.sugar, 
      this.carbohydrates, 
      this.protein,});

  Nutritions.fromJson(dynamic json) {
    calories = json['calories'];
    fat = json['fat'];
    sugar = json['sugar'];
    carbohydrates = json['carbohydrates'];
    protein = json['protein'];
  }
  num? calories;
  num? fat;
  num? sugar;
  num? carbohydrates;
  num? protein;
Nutritions copyWith({  num? calories,
  num? fat,
  num? sugar,
  num? carbohydrates,
  num? protein,
}) => Nutritions(  calories: calories ?? this.calories,
  fat: fat ?? this.fat,
  sugar: sugar ?? this.sugar,
  carbohydrates: carbohydrates ?? this.carbohydrates,
  protein: protein ?? this.protein,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['calories'] = calories;
    map['fat'] = fat;
    map['sugar'] = sugar;
    map['carbohydrates'] = carbohydrates;
    map['protein'] = protein;
    return map;
  }

}

class FruitList {
  List<FruitModel> fruitList = [];

  FruitList({required this.fruitList});

  factory FruitList.fromJson(List<dynamic> parsedJson){

    if(parsedJson.isEmpty){
      return  FruitList(fruitList: []);
    }

    List<FruitModel> list = parsedJson.map((i) => FruitModel.fromJson(i)).toList();
    return FruitList(
      fruitList: list,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fruitList'] = fruitList.map((v) => v.toJson()).toList();
    return data;
  }
}