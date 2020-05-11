import 'dart:convert';

class User {
  String uid;
  String name;
  String phone;
  String image;
  String thumb;
  User({
    this.uid,
    this.name,
    this.phone,
    this.image,
    this.thumb,
  });

  User copyWith({
    String uid,
    String name,
    String phone,
    String image,
    String thumb,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      thumb: thumb ?? this.thumb,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'image': image,
      'thumb': thumb,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      image: map['image'],
      thumb: map['thumb'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, phone: $phone, image: $image, thumb: $thumb)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.uid == uid &&
        o.name == name &&
        o.phone == phone &&
        o.image == image &&
        o.thumb == thumb;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        thumb.hashCode;
  }
}
