abstract class BaseModel {
  final String? id;

  String? get mainAttribute => null;

  Map<String, Object> toMap();

  const BaseModel({required this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
