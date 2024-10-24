abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T> create(T transaction);
  Future<void> update(T transaction);
  Future<void> delete(T transaction);
}
