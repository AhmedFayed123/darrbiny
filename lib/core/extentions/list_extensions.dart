// extensions/list_extensions.dart
extension ListExtensions<T> on List<T> {
  List<T> get unique {
    return toSet().toList();
  }
}
