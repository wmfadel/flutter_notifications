import 'package:flutter/material.dart';
import 'package:flutter_notifications/notifications_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final NotificationsHelper notificationsHelper = NotificationsHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Local Botifications'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TextButton(
              child: Text('Normal notification'),
              onPressed: () => notificationsHelper.showNotification(
                title: 'My Event title',
                body: 'Come and and join my new event',
                //resource,id
                payload: 'EVENT,10',
              ),
            ),
            TextButton(
                child: Text('Scheduled notification'),
                onPressed: notificationsHelper.showScheduledNotification),
            TextButton(
                child: Text('Periodic notification'),
                onPressed: notificationsHelper.showPeriodicNotification),
            TextButton(
                child: Text('Cancel All notifications'),
                onPressed: notificationsHelper.cancelAllNotifications),
          ],
        ),
      ),
    );
  }
}
