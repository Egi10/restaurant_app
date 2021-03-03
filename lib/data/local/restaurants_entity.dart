class RestaurantsEntity {
  String id;
  String name;
  String description;
  String picture;
  String city;

  RestaurantsEntity(
      this.id, this.name, this.description, this.picture, this.city);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'picture': picture,
      'city': city
    };
  }

  RestaurantsEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    picture = map['picture'];
    city = map['city'];
  }
}
