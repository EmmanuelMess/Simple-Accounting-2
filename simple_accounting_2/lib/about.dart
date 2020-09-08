import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

final version = "v1.0.0";

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('About').tr(),
        ),
        body: Builder(
          builder: (context) =>
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: 144.0,
                      height: 144.0,
                      margin: EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00F9C1),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'lib/drawable/ic_launcher_foreground.png'),
                          )
                      ),
                    ),
                    Text(
                      'name',
                      textScaleFactor: 2.0,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ).tr(),
                    const SizedBox(height: 8),
                    Text(
                      "version",
                      textScaleFactor: 1,
                    ).tr(args: [version]),
                    const Divider(
                      color: Colors.grey,
                      height: 16.0,
                      thickness: 1,
                      indent: 8,
                      endIndent: 8,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'description',
                          textScaleFactor: 1.25,
                          textAlign: TextAlign.center,
                        ).tr()
                    ),
                  ],
                ),
              ),
        ),
      );
}