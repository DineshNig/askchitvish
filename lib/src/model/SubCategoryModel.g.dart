// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubCategoryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryModel subCategoryModelFromJson(Map<String, dynamic> json) {
  return SubCategoryModel(
    id: json['id'] as String,
    catg_id: json['catg_id'] as String,
    topic_name: json['topic_name'] as String,
    short_desc: json['short_desc'] as String,
    ingredients1: json['ingredients1'] as String,
    method1: json['method1'] as String,
    order_no: json['order_no'] as String,
    times_viewed: json['times_viewed'] as String,
    images: json['images'] as String,
    audio: json['audio'] as String,
    video: json['video'] as String,
    active: json['active'] as String,
    favon: json['favon'] as String,
  );
}

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'catg_id': instance.catg_id,
      'topic_name': instance.topic_name,
      'short_desc': instance.short_desc,
      'ingredients1': instance.ingredients1,
      'method1': instance.method1,
      'order_no': instance.order_no,
      'times_viewed': instance.times_viewed,
      'images': instance.images,
      'audio': instance.audio,
      'video': instance.video,
      'active': instance.active,
      'favon': instance.favon,
    };
