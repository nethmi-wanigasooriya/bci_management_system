abstract class BaseService<T> {
  final List<T> _items = [];

  List<T> get items => List.unmodifiable(_items);

  void add(T item) {
    _items.add(item);
  }

  void removeWhere(bool Function(T item) test) {
    _items.removeWhere(test);
  }
}