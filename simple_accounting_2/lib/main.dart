import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('es')],
    path: 'lib/l10n',
    fallbackLocale: Locale('en'),
    useOnlyLangCode: true,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => 'name'.tr(),
      theme: ThemeData(
        primarySwatch: Colors.amber,//TODO better colors
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('name').tr(),
      ),
      body: Table(
        border: TableBorder.all(
            color: Colors.black26,
            width: 1,
            style: BorderStyle.none
        ),
        children: [
          TableRow(children: [
            TableCell(child: Text('date').tr()),
            TableCell(child: Center(child: Text('reference').tr()),),
            TableCell(child: Center(child: Text('credit').tr()),),
            TableCell(child: Center(child: Text('debit').tr()),),
            TableCell(child: Center(child: Text('total').tr()),),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(child: Text('12')),
              verticalAlignment: TableCellVerticalAlignment.middle,
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(child: Text('Thing')),
            ),
            TableCell(
              child: Center(child: Text('0')),
              verticalAlignment: TableCellVerticalAlignment.top,
            ),
            TableCell(
              child: Center(child: Text('0')),
              verticalAlignment: TableCellVerticalAlignment.top,
            ),
            TableCell(
              child: Center(child: Text('\$ 0')),
              verticalAlignment: TableCellVerticalAlignment.top,
            ),
          ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
