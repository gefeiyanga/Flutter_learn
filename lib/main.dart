import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home page'),
      // 注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
        "home": (context) => MyHomePage(title: 'Flutter Demo Home page'),
        "observeStatePage": (context) => ObserveStateRoute(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
                'You have pushed the button this many times:'
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
                child: Text("open new route"),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return NewRoute();
                    })
                  );
                }),
            Image(
              image: AssetImage("imgs/dog.jpg"),
              width: 60.0,
            ),
//            Image(
//              image: NetworkImage(
//                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
//              width: 60.0,
//            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ParentWidgetC(),
                RandomWordsWidget(),
                TapboxA(),
                ParentWidget(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'observeStatePage',),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

/*
* 路由跳转传值
* */

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RouterTestRoute()
        ]
      ),
    );

  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是页面关闭是给上一个页面的返回值"),
                child: Text("返回"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'home',),
        tooltip: 'BackHome',
        child: new Icon(Icons.home),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          new RaisedButton(
            child: Text('提示'),
            onPressed: () async {
              // 打开`TipRoute`，并等待返回结果
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return TipRoute(
                      // 路由参数
                        text: "我是提示xxxx啊"
                    );
                  })
              );
              // 输出`TipRoute`路由返回结果
              print("路由返回值：$result");
            },
          ),
          new Text("打开提示页"),
          new FormTest(),
        ],
      ),
    );
  }
}

/*
* 引入一个包
* */

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

/*
* State
*/

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0,
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    // 初始化状态
    _counter=widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('observe'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Text('$_counter'),
          onPressed: ()=>setState(()=>++_counter),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class ObserveStateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return CounterWidget();
  }
}


/*
* 状态管理
* */

// 1. Widget管理自身状态

// -------TapboxA--------

class TapboxA extends StatefulWidget {
  TapboxA({Key key,}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}


class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 160.0,
        height: 160.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600]
        ),
      ),
    );
  }
}

// 2. 父Widget管理子Widget的状态

// ---------ParentWidget----------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

// ----------TapboxB----------

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 160.0,
        height: 160.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

// 3. 混合状态管理

// -----------ParentWidgetC------------

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {

  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChange: _handleTapboxChanged,
      ),
    );
  }
}

// ------------TapboxC------------
class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChange})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChange;

  @override
  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChange(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // 按下是添加绿色边框，抬起时取消高亮
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Center(
          child: new Text(
            widget.active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 160.0,
        height: 160.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? new Border.all(
            color: Colors.teal[700],
            width: 10.0,
          ) : null
        ),
      ),
    );
  }
}

class FormTest extends StatefulWidget {
  @override
  _FormTestState createState() => new _FormTestState();
}

class _FormTestState extends State<FormTest> {
//  FocusNode focusNode1 = new FocusNode();
//  FocusNode focusNode2 = new FocusNode();
//  FocusScopeNode focusScopeNode;

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,  // 设置globalKey，用于后面获取FormState
        autovalidate: true,
        child: Column(
          children: <Widget>[

//            RaisedButton(
//              child: Text('去布局路由'),
//              onPressed: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) {
//                      return RowRoute();
//                    })
//                );
//              }
//            ),
//            RaisedButton(
//                child: Text('去流式布局路由'),
//                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) {
//                        return WrapRoute();
//                      })
//                  );
//                }
//            ),
//            RaisedButton(
//                child: Text('去层叠布局路由'),
//                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) {
//                        return StackRoute();
//                      })
//                  );
//                }
//            ),
//            RaisedButton(
//                child: Text('去对齐与相对定位布局路由'),
//                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) {
//                        return AlignRoute();
//                      })
//                  );
//                }
//            ),
            RaisedButton(
                child: Text('去对脚手架配置路由'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return ScaffoldRoute();
                      })
                  );
                }
            ),
            /*
            * 进度条
            * */

            // 模糊进度条（绘执行一个动画）
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: 1,
            ),
            // 进度显示50%
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: '请输入用户名',
                hintText: '用户名或邮箱',
                prefixIcon: Icon(Icons.person),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // 获得焦点下划线为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
                // 校验用户名
              ),
              validator: (v) {
                return v.trim().length > 0 ? null : '用户名不能为空';
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "请输入密码",
                  hintText: '您的登录密码',
                  prefixIcon: Icon(Icons.lock),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  // 获得焦点下划线为蓝色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)
              ),
              validator: (v) {
                return v.trim().length > 6 ? null : '密码不能少于六位';
              },
            ),
            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.all(18.0),
                      child: Text("登录"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        // 在这里不能通过此方式获得FormState, context不对
                        // print(Form.of(context));

                        // 通过_formKey.currentState获取FormState后
                        // 调用validate()方法校验用户名、密码是否合法
                        // 校验通过后在提交数据
                        if((_formKey.currentState as FormState).validate()) {
                          // 校验通过提交数据
                          print('校验通过了...');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
//            Builder(builder: (ctx) {
//              return Column(
//                children: <Widget>[
//                  RaisedButton(
//                      child: Text('移动焦点'),
//                      onPressed: () {
//                        // 将焦点从第一个TextField移动到第二个TextField
//                        // 第一种写法：
//                        // FocusScope.of(context).requestFocus(focusNode2);
//                        // 第二种写法：
//                        if(null == focusScopeNode) {
//                          focusScopeNode = FocusScope.of(context);
//                        }
//                        focusScopeNode.requestFocus(focusNode2);
//                      }
//                  ),
//                  RaisedButton(
//                      child: Text("隐藏键盘"),
//                      onPressed: () {
//                        focusNode1.unfocus();
//                        focusNode2.unfocus();
//                      }
//                  ),
//                ],
//              );
//            })
          ],
        ),
      ),
    );
  }
}

/*
* Row
* */

class RowRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局')
      ),
      body: Column(
        // 测试Row对齐方式
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello World!'),
              Text("I'm lucy"),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello World!'),
              Text("I'm lucy"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text('Hello World!'),
              Text("I'm lucy"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Text('Hello World!',  style: TextStyle(fontSize: 30.0),),
              Text("I'm lucy"),
            ],
          ),
        ],
      ),
    );
  }
}

// 流式布局
class WrapRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('流式布局'),),
        body: Wrap(
        spacing: 8.0,  // 主轴（水平）方向间距
        runSpacing: 4.0,  // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center,  // 沿主轴方向居中
        children: <Widget>[
          new Chip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
            label: Text('Hamilton'),
          ),
          new Chip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
            label: Text('Lafayette'),
          ),
          new Chip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
            label: Text('Mulligan'),
          ),
          new Chip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
            label: Text('Laurens'),
          )
        ],
      ),
    );
  }
}

// 层叠布局
class StackRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('层叠布局'),),
      body: new ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,  // 指定未定位或者部分定位的Widget的对其方式
          fit: StackFit.expand,  // 未定位的Widget占满Stack整个空间
          children: <Widget>[
            Positioned(
              left: 18.0,
              child: Text('I am Jack')
            ),
            Container(
              child: Text('Hello Wrold', style: TextStyle(color: Colors.white),),
              color: Colors.red,
            ),
            Positioned(
              top: 18.0,
              child: Text('I am Lucy'),
            )
            // 可以看到，由于第二个子文本组件没有定位，所以fit属性会对它起作用，就会占满整个Stack。
            // 由于Stack子元素是堆叠的，所以第一个子文本组件被第二个遮住了，而第三个在最上层，正常显示
          ],
        ),
      ),
    );
  }
}

// Align
class AlignRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('对齐'),),
      body: Container(
//        height: 120.0,
//        width: 120.0,
        color: Colors.blue[600],
        child: Align(
          widthFactor: 4,
          heightFactor: 4,
          // alignment: Alignment.topRight,
          alignment: Alignment(1, 0.0),
          child: FlutterLogo(
            size: 60.0,
          ),
        ),
      ),
    );
  }
}


// Scaffold TabBar 底部导航

class ScaffoldRoute extends StatefulWidget{

  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
  with SingleTickerProviderStateMixin {

  TabController _tabController;  // 需要定义一个controller
  List tabs = ['新闻', '历史', '图片'];

  int _selsectIndex = 1;

  @override
  void initState() {
    super.initState();
    // 创建controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('App Name'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white,),
            onPressed: () => Scaffold.of(context).openDrawer()  // 打开抽屉
          );
        },),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: ()=>{}),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 4),
          );
        }).toList(),
      ),
      drawer: new MyDrawer(),  // 抽屉
//      bottomNavigationBar: BottomNavigationBar(
//        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
//          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
//        ],
//        currentIndex: _selsectIndex,
//        fixedColor: Colors.blue,
//        onTap: _onItemTapped,
//      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),  // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home)),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.business)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,  // 均分地步导航栏的横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selsectIndex = index;
    });
  }

  void _onAdd() {
    print('点了悬浮按钮');
  }
}

class MyDrawer extends StatefulWidget {

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // 移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset('imgs/dog.jpg',
                        width: 60,
                      ),
                    ),
                  ),
                  Text(
                    "Variousdid",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}


















