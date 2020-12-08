import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({
    @required this.data,
    Widget child
  }) : super(child: child);

  final int data;  // 需要在子树中共享的数据，保存点击次数

  // 定义一个便捷方法，方便子树Widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    // 如果返回true，则子树中依赖（build函数中有调用）本widget
    // 的子widget的`state.didChangeDependencies`会被调用
    return old.data != data;
  }
}

// 然后实现一个子组建_TestWidget,在其build方法中引用ShareDataWidget中的数据。
// 同时，在其didChangeDependencies()回调中打印日志：

class _TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => new _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    // 使用InheritedWidget中的共享数据
    return Text(ShareDataWidget
      .of(context)
      .data
      .toString()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先Widget中的InheritedWidget改变（updateShouldNotify返回true）时会被调用
    // 如果build中没有依赖InheritedWidget，则此回调不会被调用
    print("Dependencies Change");
  }
}

// 最后，创建一个按钮，每点击一次，就将ShareDataWidget的值自增
class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() => new _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(  // 使用ShareDataWidget
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: _TestWidget(),  // 子Widget中依赖ShareDataWidget
            ),
            RaisedButton(
              child: Text("Increment"),
              // 每点击一次，将count自增，然后重新build，ShareDataWidget的data将会被更新
              onPressed: ()=>setState(()=>{ ++count }),
            )
          ],
        ),
      ),
    );
  }
}












