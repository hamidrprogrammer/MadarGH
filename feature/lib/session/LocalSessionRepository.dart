abstract class LocalSessionRepository {
  void insertData(Map<String,String> data);
  Future<String> getData(String key);
  Future<bool> clearSession();
}