import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../form/widget/form_button.dart';
import 'cubit/notification_cubit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWrapperProvider extends StatelessWidget {
  const NotificationWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationCubit>(),
      child: const NotificationPage(title: "Notification Panel"),
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, required this.title});
  final String title;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
      builder: (context, ThemeService themeService, LanguageService languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormButton(
                  label: 'Notification Basic',
                  onPressed: () async {
                    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
                        'your channel id',
                        'your channel name',
                        channelDescription: 'your channel description',
                        importance: Importance.max,
                        priority: Priority.high,
                        ticker: 'ticker'
                    );
                    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
                    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item x');
                  },
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      }
    );
  }

}