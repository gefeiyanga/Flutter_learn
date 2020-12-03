class Student extends Person {
  // 定义私有变量
  String _school;
  String city;
  String country;
  String name;
  Student(this._school, String name, int age, {this.city, this.country='China'})
      :
        name='$country.$city',
        super(name, age);

}


// 定义一个Dart类，所有的类都继承自Object
class Person {
  String name;
  int age;
  // 标准构造方法
  Person(this.name, this.age);
  // 重写父类方法
  @override
  String toString() {
    // TODO: implement toString
    return 'name: $name, age: $age';
  }
}

