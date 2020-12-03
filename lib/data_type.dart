import 'package:flutter/material.dart';

class DataType extends StatefulWidget {
  @override
  _DataTypeState createState() => _DataTypeState();
}

class _DataTypeState extends State<DataType> {
  @override
  Widget build(BuildContext context) {
    _numType();
    _listType();
    _mapType();
    return Container(
      child: Text('常用数据类型，请查看控制台输出'),
    );
  }

  // 数字类型
  void _numType() {
    num num1 = -1.0;  // 是数字类型的父类
    num num2 = 2;  // 是数字类型的父类
    int int1 = 3; // 只能是整数
    double d1 = 4.33;  // 双精度
    print("num1: $num1  num2: $num2  int1: $int1  d1: $d1");
    num1.toInt();
    print(num1.toInt());
    print(num1);
  }

  // List集合
  _listType() {
    print('-----------------');
    // 集合的初始化
    List list = [1, 2, 3, '集合'];  // 初始化时添加元素
    print(list);
    List<int> list2 = [1, 2, 3];
    // list2 = list;
    List list3 = [];
    list3.add('list3');  // 通过add方法添加元素
    list3.addAll(list);
    print(list3);
    List list4 = List.generate(3, (index) => index*2);
    print(list4);


    // 集合遍历
    for(int i=0; i<list.length; i++) {
      print(list[i]);
    }

    for(var i in list) {
      print(i);
    }
    list.forEach((element) {
      print(element);
    });
  }

  // Map是key—value相关联对象

  _mapType() {
    print('--------------');
    Map names = {
      'xiaoming': '小明',
      'xiaohong': '小红'
    };
    Map ages = {};
    ages['xiaoming'] = 19;
    ages['xiaohong'] = '21';
    print(names);
    print(ages);

    // Map遍历
    ages.forEach((key, value) {
      print('$key: $value');
    });
    Map ages2 = ages.map((key, value) {
      return MapEntry(value, key);
    });
    print(ages2);
    for(var key in ages.keys) {
      print('$key ${ages[key]}');
    }
  }
}
