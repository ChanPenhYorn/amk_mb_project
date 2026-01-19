import 'package:amk_bank_project/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({required super.id, required super.title, required super.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }
}
