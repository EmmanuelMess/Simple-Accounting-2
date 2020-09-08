import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_accounting_2/db/entity/month.dart';

import 'db/dao/month_dao.dart';

class MonthsPage extends StatefulWidget {
  final MonthDao monthsDao;

  MonthsPage(this.monthsDao, {Key key}) : super(key: key);

  @override
  _MonthsPageState createState() => _MonthsPageState(this.monthsDao);
}

class _MonthsPageState extends State<MonthsPage> {
  final MonthDao monthsDao;

  _MonthsPageState(this.monthsDao) : super();

  Widget _createMonth(final BuildContext context, final Month month) {
    return MonthCard(
      month,
      () => Navigator.pop(context),
    );
  }

  Widget _createMonths(BuildContext context) {
    return StreamBuilder<List<Month>>(
      stream: monthsDao.findAllMonthsAsStream(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return ListView();

        final tasks = snapshot.data;

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            return _createMonth(context, tasks[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('months').tr(),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: _createMonths(context),
      ),
    );
  }
}

class MonthCard extends StatelessWidget {
  const MonthCard(
    this.month,
    this.onPressed, {
    Key key,
  }) : super(key: key);

  final Month month;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.black12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(month.month.toString()),
            subtitle: Text(month.year.toString()),
            trailing: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}