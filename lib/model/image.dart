import 'pivot.dart';

class Images {
  int id;
  String title;
  String type;
  String source;
  String createdAt;
  String updatedAt;
  Pivot pivot;
  String imageUrl;

  Images(
      {this.id,
      this.title,
      this.type,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.pivot,
      this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['source'] = this.source;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    data['image_url'] = this.imageUrl;
    return data;
  }
}
