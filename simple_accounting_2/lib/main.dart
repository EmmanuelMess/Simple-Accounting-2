import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.amber, //TODO better colors
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => 'name'.tr(),
      theme: theme(),
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
  int _counter = 1;

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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FittedBox(
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text('date').tr()
                      ),
                      DataColumn(
                          label: Text('reference').tr()
                      ),
                      DataColumn(
                          label: Text('credit').tr()
                      ),
                      DataColumn(
                          label: Text('debit').tr()
                      ),
                      DataColumn(
                        label: Text(
                          'total',
                          textAlign: TextAlign.end,
                        ).tr(),
                      ),
                    ],
                    rows: [
                      createTableRow(
                        AccountingRowFormatted(
                          "12",
                          "Things\n\n\ns",
                          "100",
                          "100",
                          "\$ 0",
                        ),
                        context,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  final TABLE_ROW_TEXT_SIZE = TextStyle(fontSize: 24.0);

  DataRow createTableRow(AccountingRowFormatted strings, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(strings.date, textAlign: TextAlign.start)),
        DataCell(Text(strings.reference)),
        DataCell(Text(strings.row3)),
        DataCell(Text(strings.row4)),
        DataCell(Text(strings.total, textAlign: TextAlign.end)),
      ],
      onSelectChanged: (bool selected) {
        if (selected) {
          showBarModalBottomSheet(
            context: context,
            builder: (context, scrollController) =>
                Material(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: RaisedButton(
                                child: Text('edit').tr(),
                                onPressed: () {

                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: RaisedButton(
                                child: Text(
                                  'changeOrdering',
                                  textAlign: TextAlign.center,
                                ).tr(),
                                onPressed: () {

                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                'date'.tr() + ': ' + strings.date,
                                style: TABLE_ROW_TEXT_SIZE,
                              ),
                              //TODO use params in translation
                              Text(
                                'reference'.tr() + ': ',
                                style: TABLE_ROW_TEXT_SIZE,
                              ),
                              //TODO use params in translation
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  strings.reference,
                                  style: TABLE_ROW_TEXT_SIZE,
                                ),
                              ),
                              //TODO use params in translation
                              Text(
                                'debit'.tr() + ': ' + strings.row3,
                                style: TABLE_ROW_TEXT_SIZE,
                              ),
                              //TODO use params in translation
                              Text(
                                'credit'.tr() + ': ' + strings.row4,
                                style: TABLE_ROW_TEXT_SIZE,
                              ),
                              //TODO use params in translation
                              Text(
                                '(' + 'total'.tr() + ': ' + strings.total + ')',
                                style: TABLE_ROW_TEXT_SIZE,
                              ),
                              //TODO use params in translation
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          );
        }
      },
    );
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