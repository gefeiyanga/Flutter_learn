import 'package:flutter/cupertino.dart';

// 一个通用的InheritedWidget,保存需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  // 共享状态使用范性
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    // 在此简单的返回true，则每次更新都会调用依赖他的子孙节点的`didChangeDependencies`
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

//  // 定义一个便捷方法，方便子树中的Widget获取共享数据
//  static T of<T>(BuildContext context) {
////    final type = _typeOf<InheritedProvider<T>>();
//    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
//    return provider.data;
//  }

// 添加一个listen参数，表示是否建立依赖关系
  static T of<T>(BuildContext context, {bool listen = true}) {
//    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen ?
    context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget
    as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}


// 上面的类继承StatefulWidget，然后定义了一个of()静态方法供子类方便获取Widget树中的
// InheritedProvider中保存的共享状态(model)，下面我们实现该类对应的
// _ChangeNotifierProviderState类

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    // 如果数据发生变化（model类调用了notifyListeners）,重新构建InheritedProvider
    setState(() {

    });
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 当Provoder更新时，如果旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}























