import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_accounting_2/db/dao/account_row_dao.dart';
import 'package:simple_accounting_2/db/dao/month_dao.dart';
import 'package:simple_accounting_2/add_row.dart';

import 'about.dart';
import 'db/database.dart';
import 'formatter/formatted_row.dart';
import 'months.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db')
      .build();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('es')],
    path: 'lib/l10n',
    fallbackLocale: Locale('en'),
    useOnlyLangCode: true,
    child: SimpleAccounting2App(database.accountRowDao, database.monthDao),
  ));
}

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.amber, //TODO better colors
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder()),
  );
}

class SimpleAccounting2App extends StatelessWidget {
  final AccountRowDao accountRowDao;
  final MonthDao monthDao;

  const SimpleAccounting2App(this.accountRowDao, this.monthDao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => 'name'.tr(),
      theme: theme(),
      home: MainPage(this.accountRowDao, this.monthDao),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class MainPage extends StatefulWidget {
  final AccountRowDao accountRowDao;
  final MonthDao monthDao;

  MainPage(this.accountRowDao, this.monthDao, {Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(this.accountRowDao, this.monthDao);
}

class _MainPageState extends State<MainPage> {
  final AccountRowDao accountRowDao;
  final MonthDao monthDao;

  _MainPageState(this.accountRowDao, this.monthDao) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('name').tr(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'months'.tr(),
            onPressed: () =>
                Navigator.push(
                  context,
                  _slideRouteAnimation((_, __, ___) => MonthsPage(this.monthDao)),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'about'.tr(),
            onPressed: () =>
                Navigator.push(
                  context,
                  _slideRouteAnimation((_, __, ___) => AboutPage()),
                ),
          ),
        ],
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
          showDialog(
            context: context,
            builder: (BuildContext context) => AddRowDialog(this.monthDao, this.accountRowDao),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Route _slideRouteAnimation(final RoutePageBuilder pageBuilder) {
    return PageRouteBuilder(
      pageBuilder: pageBuilder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(
              CurveTween(curve: Curves.ease),
            ),
          ),
          child: child,
        );
      },
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
          _showRowBottomSheet(context);
        }
      },
    );
  }

  void _showRowBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('edit').tr(),
                    onTap: () {
                      Navigator.pop(context);
                    }
                ),
                ListTile(
                    leading: Icon(Icons.sort),
                    title: Text('changeOrdering').tr(),
                    onTap: () {
                      Navigator.pop(context);
                    }
                ),
                ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text('delete').tr(),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}