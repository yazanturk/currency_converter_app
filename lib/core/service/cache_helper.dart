import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CacheHelper {
  CacheHelper._();

  static final CacheHelper instance = CacheHelper._();
  Future<T?> hiveGetDataById<T>(int id) async {
    var i = await Hive.openBox<T>('currency');
    return i.get(id);
  }

  Future<void> hivePutData<T>(T object) async {
    try {
      var i = await Hive.openBox<T>('currency');
      await i.put(0, object);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
