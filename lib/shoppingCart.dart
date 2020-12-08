import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutterdartlearn/provider.dart';

class Item {
  Item(this.price, this.count);
  double price;
  int count;
}

// 定义一个保存购物车内商品数据的CartModel类
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];
  
  // 禁止改变购物车中商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);
  
  // 购物车中商品的总价
  double get totalPrice =>
    _items.fold(0, (previousValue, item) => previousValue + item.count * item.price);

  // 将[item]添加到购物车。这是唯一一种能从外部改变购物车的方法
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider，更新状态
    notifyListeners();
  }
}

// CartModel 即要跨组件共享的model类。最后我们构建示例页面
class ProviderRoute extends StatefulWidget {
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('跨组件状态管理(Provider)'),),
            body: Column(
              children: <Widget>[
//                Builder(builder: (context) {
//                  var cart = ChangeNotifierProvider.of<CartModel>(context);
//                  return Text("总价： ${cart.totalPrice}");
//                },),
                // 优化为
                Consumer<CartModel> (
                  builder: (context, cart) => Text("总价：${cart.totalPrice}"),
                ),
                Builder(builder: (context) {
                  print('RaisedButton build');  // 后面优化部分用的到
                  return RaisedButton(
                    child: Text("添加商品"),
                    onPressed: () {
                      // 给购物车中添加商品，添加后总价会更新
//                      ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
                      // 性能优化为
                      ChangeNotifierProvider.of<CartModel>(context, listen: false).add(Item(20.0, 1));
                    },
                  );
                },)
              ],
            ),
          );
        },),
      ),
    );
  }
}

// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  Consumer({
    Key key,
    @required this.builder,
    this.child,
  }) : assert(builder != null),
        super(key: key);

  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),  // 自动获取Model
    );
  }
}

// 以上代码性能方便优化和React hooks中的useCallback--memo 相似，避免不必要的渲染



























