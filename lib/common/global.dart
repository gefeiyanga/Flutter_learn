// 提供五套可选的主题色
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index.dart';

const _themes = <MaterialColor> [
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否是release版本
  static bool get isRelease => true || bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，会在app启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
//    print('_prefs: $_prefs');
    var _profile = _prefs.getString('profile');
    if(_profile != null) {
      try {
//        print('1${jsonDecode(_profile)}');
//        print('2${Profile.fromJson(jsonDecode(_profile))}');
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch(e) {
        print(e);
      }
    }

    // 如果没有缓存策略，获取默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    // 初始化网络请求相关配置
    Git.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
    _prefs.setString('profile', jsonEncode(profile.toJson()));
}
