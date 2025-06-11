/// name : "Ali"
/// email : "alisamirroute122@gmail.com"
/// role : "user"

class User {
  User({
    this.name,
    this.email,
    this.role,
    this.id, // إضافة حقل id
    this.createdAt, // إضافة حقل createdAt
    this.updatedAt,
  });

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    id = json['id'];                   // معالجة الحقل الجديد
    createdAt = json['created_at'];    // معالجة الحقل الجديد
    updatedAt = json['updated_at']; 
  }
  String? name;
  String? email;
  String? role;
   dynamic id;          // يمكنك استخدام String أو int حسب نوع ID
  String? createdAt;   // تاريخ الإنشاء
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['id'] = id;                   // إضافة الحقل الجديد
    map['created_at'] = createdAt;    // إضافة الحقل الجديد
    map['updated_at'] = updatedAt; 
    return map;
  }
}
