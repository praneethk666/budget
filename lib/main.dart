import 'package:budget/widgets/chart.dart';
import 'package:budget/widgets/newtranseactions.dart';
import 'package:budget/widgets/transactionslist.dart';
import 'package:flutter/material.dart';
import 'models/transactions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final List<Transactions> _userT = [];
  bool _showChart = false;
  List<Transactions> get _recentTrans {
    return _userT.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewT(String titled, double amountd, DateTime chosenD) {
    final newTx = Transactions(
        title: titled, amount: amountd, date: chosenD, id: DateTime.now());
    setState(() {
      _userT.add(newTx);
    });
  }

  void _startNewT(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return MyWidget(_addNewT);
        });
  }

  void deleteTrans(DateTime id) {
    setState(() {
      _userT.removeWhere((element) => element.id == id);
    });
  }
  PreferredSizeWidget appBAr(){
    return AppBar(actions: [
          IconButton(
              onPressed: () => _startNewT(context), icon: const Icon(Icons.add))
        ],
        backgroundColor: const Color.fromARGB(255, 64, 78, 120),
        centerTitle: true,
        title: const Text(
          "PLAN YOUR BUDGET",
        ));
  }

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context);
    final isLand = md.orientation ==  Orientation.landscape;
    final appBar = AppBar(actions: [
          IconButton(
              onPressed: () => _startNewT(context), icon: const Icon(Icons.add))
        ],
        backgroundColor: const Color.fromARGB(255, 64, 78, 120),
        centerTitle: true,
        title: const Text(
          "PLAN YOUR BUDGET",
        ));
        final tList = Container(
                  height: (md.size.height -
                          appBar.preferredSize.height -
                          md.padding.top) *
                      0.7,
                  child: T(_userT, deleteTrans));
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'OpenSans',
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: "Quicksand",
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBAr(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if(isLand)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(value: _showChart, onChanged: (val){
                    setState(() {
                      _showChart =val;
                    });
                  },),
                ],
              ),
              if(!isLand) Container(
                  height: (md.size.height -
                          appBar.preferredSize.height -
                          md.padding.top) *
                      0.3,
                  child: MyWidget1(_recentTrans),),
              if(!isLand) tList,
              if(isLand) _showChart?Container(
                  height: (md.size.height -
                          appBar.preferredSize.height -
                          md.padding.top) *
                      0.7,
                  child: MyWidget1(_recentTrans))
             :tList,
            ]
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 64, 78, 120),
          child: const Icon(Icons.add),
          onPressed: () => _startNewT(context),
        ),
      ),
    );
  }
}
