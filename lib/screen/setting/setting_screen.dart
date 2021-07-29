import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widget/custom_dialog.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Setting',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.start,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ListTile(
              title: Text(
                'Restaurant Notification',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Enable notification',
                style: TextStyle(fontSize: 12),
              ),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledRestaurant(value);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
