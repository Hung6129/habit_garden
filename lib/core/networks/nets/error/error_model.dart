import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorModel {
  int statusCode;
  String statusMessage;
  bool success;

  ErrorModel(this.statusCode, this.statusMessage, this.success);

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return _$ErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

  @override
  String toString() {
    return 'ErrorModel{statusCode: $statusCode, statusMessage: $statusMessage, success: $success}';
  }
}
