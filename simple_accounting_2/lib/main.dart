import 'package:decimal/decimal.dart';
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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
            children: [
              Center(child: Text(
                'month',
                style: TextStyle(fontWeight: FontWeight.bold),
              ).tr()),
              Table(
                children: [
                  TableRow(children: [
                    TableCell(child: Text('date').tr()),
                    TableCell(child: Center(child: Text('reference').tr()),),
                    TableCell(child: Center(child: Text('credit').tr()),),
                    TableCell(child: Center(child: Text('debit').tr()),),
                    TableCell(child: Text(
                      'total',
                      textAlign: TextAlign.end,
                    ).tr(),
                    ),
                  ]),
                  createTableRow(AccountingRowFormatted(
                    "12",
                    "Things\n\n\ns",
                    "100",
                    "100",
                    "\$ 0",
                  )),
                ],
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  TableRow createTableRow(AccountingRowFormatted strings) {
    return TableRow(children: [
      TableCell(
        child: Text(strings.date),
        verticalAlignment: TableCellVerticalAlignment.top,
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(child: Text(strings.reference)),
      ),
      TableCell(
        child: Center(child: Text(strings.row3.toString())),
        verticalAlignment: TableCellVerticalAlignment.bottom,
      ),
      TableCell(
        child: Center(child: Text(strings.row4.toString())),
        verticalAlignment: TableCellVerticalAlignment.bottom,
      ),
      TableCell(
        child: Text(
          strings.total,
          textAlign: TextAlign.end,
        ),
        verticalAlignment: TableCellVerticalAlignment.bottom,
      ),
    ]);
  }
}

class AccountingRowFormatted {
  AccountingRowFormatted(this.date, this.reference, this.row3, this.row4, this.total);

  final String date;
  final String reference;
  final String row3;
  final String row4;
  final String total;
}