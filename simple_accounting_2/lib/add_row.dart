import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'logic/decimal_conversion.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class AddRowDialog extends StatelessWidget {
  final String total;

  AddRowDialog({this.total});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: AddRowWidget(total: this.total),
    );
  }
}

class AddRowWidget extends StatefulWidget {
  String date, reference, debit, credit;
  final String total;

  AddRowWidget({
    this.total,
    Key key,
  }) : super(key: key);

  @override
  _AddRowWidgetState createState() =>
      _AddRowWidgetState(total: this.total);
}

class _AddRowWidgetState extends State<AddRowWidget> {
  String reference, debit, credit;
  DateTime date;
  final String total;

  _AddRowWidgetState({this.total});

  final _formKey = GlobalKey<FormState>();
  final _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return dialogContent(context);
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Consts.padding),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "addRow",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
              ),
              SizedBox(height: 16.0),
              _form(),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FlatButton(
                      child: Text('cancel').tr(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      color: Colors.amber,
                      textColor: Colors.white,
                      child: Text('save').tr(),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          /*
                      if (id == null) {
                        await deadlineDao.insertDeadline(Deadline(
                          null,
                          title,
                          deadline.millisecondsSinceEpoch,
                        ));
                      } else {
                        await deadlineDao.updateDeadline(Deadline(
                          id,
                          title,
                          deadline.millisecondsSinceEpoch,
                        ));
                      }*/
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Form _form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DateTimeField(
            initialValue: date ?? _now,
            format: DateFormat("yyyy-MM-dd HH:mm"),
            onShowPicker: (context, currentValue) async {
              await showDatePicker(
                context: context,
                firstDate: date != null && date.isBefore(_now)
                    ? date
                    : _now,
                initialDate: currentValue ?? _now,
                lastDate: DateTime(2100),
              );
              return currentValue;
            },
            validator: (value) {
              if (value.isBefore(_now) || value.isAtSameMomentAs(_now)) {
                return 'Enter a time after now'.tr();
              }
              return null;
            },
            onChanged: (DateTime value) =>
                setState(() {
                  date = value;
                }),
            onSaved: (DateTime value) =>
                setState(() {
                  date = value;
                }),
          ),
          const SizedBox(height: 24),
          TextFormField(
            initialValue: reference ?? "",
            decoration: InputDecoration(
              hintText: 'reference'.tr(),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'enterReference'.tr();
              }
              return null;
            },
            onChanged: (String value) =>
                setState(() {
                  reference = value;
                }),
            onSaved: (String value) =>
                setState(() {
                  reference = value;
                }),
          ),
          const SizedBox(height: 24),
          TextFormField(
            initialValue: debit ?? "",
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'debit'.tr(),
            ),
            validator: (value) {
              if (!DecimalConversion.check(value)) {
                return 'enterValidNumber'.tr();
              }
              return null;
            },
            onChanged: (String value) =>
                setState(() {
                  debit = value;
                }),
            onSaved: (String value) =>
                setState(() {
                  debit = value;
                }),
          ),
          const SizedBox(height: 24),
          TextFormField(
            initialValue: credit ?? "",
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'credit'.tr(),
            ),
            validator: (value) {
              if (!DecimalConversion.check(value)) {
                return 'enterValidNumber'.tr();
              }
              return null;
            },
            onChanged: (String value) =>
                setState(() {
                  credit = value;
                }),
            onSaved: (String value) =>
                setState(() {
                  credit = value;
                }),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}