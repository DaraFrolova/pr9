import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class str_Widget extends StatefulWidget {
  final Widget child;
  const str_Widget({required this.child}) : super();
  static str_WidgetState of(BuildContext context, {bool rebuild = true}) {
    //если нам нужно только получать данные и не перестраивать конкретный виджет, то ставим rebuild = false
    if (rebuild) {
      return context
          .dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!
          .data;
    }
    return context.findAncestorWidgetOfExactType<MyInheritedWidget>()!.data;
  }

  @override
  State<StatefulWidget> createState() {
    return str_WidgetState();
  }
}

class str_WidgetState extends State<str_Widget> {
  String _str = 'Test';
  String get str => _str;
  void setstr(newstr) {
    setState(() {
      _str = newstr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      child: widget.child,
      data: this,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final str_WidgetState data;
  MyInheritedWidget({
    required Widget child,
    required this.data,
  }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}


class Widget_1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    str_WidgetState data = str_Widget.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        Text('InheritedWidget работает только в рамках одного дерева-экрана. При переходе navigator.push контекст теряется ', style: TextStyle(fontSize: 20, color: Colors.limeAccent)),
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        Text(data.str, style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }
}



class Widget_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    str_WidgetState data = str_Widget.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){ data.setstr(data.str.toUpperCase()); }, child: Text('Изменить на заглавные  '+data.str,style: TextStyle(fontSize: 20, color: Colors.indigo))),
        ],
      ),
    );
  }
}

class Widget_3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    str_WidgetState data = str_Widget.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){ data.setstr(data.str.toLowerCase()); }, child: Text('Изменить на строчные '+data.str,style: TextStyle(fontSize: 20, color: Colors.indigo))),
        ],
      ),
    );
  }
}


class Widget_4 extends StatelessWidget {

  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    str_WidgetState data = str_Widget.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        new TextFormField(initialValue: data.str,  controller: _nameController,style: TextStyle(fontSize: 20, color: Colors.white), decoration: InputDecoration(hintText: 'Введите текст',),),
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){ data.setstr(_nameController.text); }, child: Text('Сохранить',style: TextStyle(fontSize: 20, color: Colors.indigo))),
        ],
      ),
    );
  }
}



class MainScreen extends StatelessWidget {

//  final sp1 = List.generate(15,(index)=>'Эллемент № ${index + 1}');

  @override

  Widget build(BuildContext context) {

     return str_Widget(

      child: Scaffold(

      appBar: AppBar(title: Text('Практической работе №9')),

      body: Container ( color: Colors.teal[700], 
        child: Center(child:  Column(children: [

        Text(' ', style: TextStyle(fontSize: 24, color: Colors.green)),
        new Text('Работа с Inherited Widget и GetIt; ', style: TextStyle(fontSize: 20, color: Colors.white)),
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {return Screen_2();},),);}, child: Text('Работа с Inherited Widget',style: TextStyle(fontSize: 14, color: Colors.indigo) )),
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Работа с GetIt')));}, child: Text('Работа с GetIt',style: TextStyle(fontSize: 14, color: Colors.indigo) ))

      ],))),

    ));

  }

}



class Screen_2 extends StatelessWidget {

  TextEditingController _nameController = TextEditingController();

//  const Screen_2({super.key});

  @override

  Widget build(BuildContext context) {

   final data = str_WidgetState();

    return Scaffold(

      appBar: AppBar(title: Text('Работа с Inherited Widget',style: TextStyle(fontSize: 20, color: Colors.white))),

      body: Center(
        child:
        Container ( color: Colors.cyan[700],  
          child: str_Widget(
        child: Center(
          child: Column(
            children: [
              Widget_1(),
              Widget_2(), 
              Widget_3(), 
              Widget_4(), 
        Text('*** ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){ Navigator.pop(context);}, child: Text('Назад',style: TextStyle(fontSize: 32, color: Colors.blue)))
            ],
          ),
        ),
      )),
    )
    );

  }

}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Пример InheritedWidget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}


abstract class AppModel extends ChangeNotifier {
  void incrementCounter();

  int get counter;
}

class AppModelImplementation extends AppModel {
  int _counter = 0;

  AppModelImplementation() {
    Future.delayed(const Duration(seconds: 3))
        .then((_) => getIt.signalReady(this));
  }

  @override
  int get counter => _counter;

  @override
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // Access the instance of the registered AppModel
    // As we don't know for sure if AppModel is already ready we use isReady
    getIt
        .isReady<AppModel>()
        .then((_) => getIt<AppModel>().addListener(update));
    // Alternative
    // getIt.getAsync<AppModel>().addListener(update);

    super.initState();
  }

  @override
  void dispose() {
    getIt<AppModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: getIt.allReady(),
          builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Center(
                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Нажмите + ',
                      ),
                      Text(getIt<AppModel>().counter.toString(), style: Theme.of(context).textTheme.headlineMedium,),
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
   ElevatedButton(onPressed: (){ Navigator.pop(context);}, child: Text('Назад',style: TextStyle(fontSize: 32, color: Colors.green)))
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: getIt<AppModel>().incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),),
              );
            }),
    );
  }
}




void main() {
  getIt.registerSingleton<AppModel>(AppModelImplementation(),
      signalsReady: true);
  runApp(MyApp());
}


