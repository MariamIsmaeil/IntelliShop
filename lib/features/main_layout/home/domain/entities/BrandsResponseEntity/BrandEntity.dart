/// _id : "64089fe824b25627a25315d1"
/// name : "Canon"
/// image : "https://ecommerce.routemisr.com/Route-Academy-brands/1678286824747.png"

class BrandEntity {
  BrandEntity({
      this.id, 
      this.name, 
      this.image, required this.slug,});

  String? id;
  String? name;
  String? image;
  String slug;

  get logo_url => null;


}