import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/datetime_cubit.dart';

class DateTimeWrapperProvider extends StatelessWidget {
  const DateTimeWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DateTimeCubit>(),
      child: const DateTimePage(title: "Date Time Picker"),
    );
  }
}

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key, required this.title});
  final String title;

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  String materialSelectedDate = "No Date";
  TimeOfDay materialSelectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
   // var ss = sl<ScreenSizeService>()..init(context);
    return Consumer2<ThemeService, LanguageService> (
      builder: (context, ThemeService themeService, LanguageService languageService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              clipBehavior: Clip.none,
              children: [
                const Text(
                  "Material - Date Picker",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      color: Theme.of(context).hintColor.toMaterialColor().shade50,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        materialSelectedDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        )
                      ),
                  )
                  )
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025)
                    );
                    if(picked != null) {
                      setState(() {
                        materialSelectedDate = picked.toString();
                      });
                    }
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0.0),
                    shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            )
                        )
                    ),
                  ),
                  child: Text(
                    "Select Date",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    )
                  ),
                ),
                const SizedBox(height: 16.0),


                const Text(
                  "Material - Time Picker",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          color: Theme.of(context).hintColor.toMaterialColor().shade50,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                              materialSelectedTime.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.inverseSurface,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              )
                          ),
                        )
                    )
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: materialSelectedTime,
                    );
                    if(picked != null) {
                      setState(() {
                        materialSelectedTime = picked;
                      });
                    }
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0.0),
                    shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            )
                        )
                    ),
                  ),
                  child: Text(
                      "Select Time",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )
                  ),
                ),
                const SizedBox(height: 16.0),

              ],
            )
          )
        );
      }
    );
  }

}

