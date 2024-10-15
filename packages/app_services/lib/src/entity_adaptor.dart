abstract class EntityAdaptor<T> {
  T fromJson(dynamic json);
  Map<String, dynamic> toMap(T value);
  List<T> fromJsonToList(dynamic json);
}
