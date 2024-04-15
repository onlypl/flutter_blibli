import 'dart:collection';
import 'dart:convert';
 
class HiLRUCache<K, V> {
  //可以做成单例 初始化从沙盒获取 
  final int _maxSize;
  final LinkedHashMap<K, V> _cache = LinkedHashMap<K, V>();
  HiLRUCache(this._maxSize);

  void put(K key, V value) {
     _cache[key] = value;
     if (_cache.length > _maxSize) {
      // 移除最老的条目，即最先插入的条目
      _cache.remove(_cache.keys.first);
    }
    update();
  }

  V? get(K key){
    return _cache[key];
  } 
  void clear() {
    _cache.clear();
    update();
  }

  void update(){
     String jsonString = jsonEncode(_cache);
     //这里要写入本地持久化
  }
}
 
// void main() {
//   final cache = LruCache<int, String>(3);
 
//   cache.put(1, 'one');
//   cache.put(2, 'two');
//   cache.put(3, 'three');
 
//   print(cache.get(1)); // 输出: one
//   print(cache.get(2)); // 输出: two
//   print(cache.get(3)); // 输出: three
 
//   cache.put(4, 'four');
 
//   print(cache.get(1)); // 输出: null
//   print(cache.get(2)); // 输出: two
//   print(cache.get(3)); // 输出: three
//   print(cache.get(4)); // 输出: four
// }