import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String cupertinoSelectedDate = "No Date";
  TimeOfDay cupertinoSelectedTime = TimeOfDay.now();
  String radioValue = "No Data";
  bool isSwitched = false;
  double sliderValue = 0.2;

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

                /// MATERIAL - DATE PICKER
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

                /// MATERIAL - TIME PICKER
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

                /// CUPERTINO - DATE PICKER
                const Text(
                  "Cupertino - Time Picker",
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
                              cupertinoSelectedDate.toString(),
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
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() {
                                cupertinoSelectedDate = newDate.toString();
                              });
                            },
                          ),
                        );
                      },
                    );
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

                /// CUPERTINO - TIME PICKER
                const Text(
                  "Cupertino - Time Picker",
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
                              cupertinoSelectedTime.toString(),
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
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, cupertinoSelectedTime.hour, cupertinoSelectedTime.minute),
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() {
                                cupertinoSelectedTime = TimeOfDay(hour: newTime.hour, minute: newTime.minute);
                              });
                            },
                          ),
                        );
                      },
                    );
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

                /// RADIO PICKER
                const Text(
                  "Radio Picker",
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
                              radioValue.toString(),
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
                Column(
                  children: <Widget>[
                    RadioListTile<String>(
                      title: const Text('Monday'),
                      value: 'Monday',
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value.toString();
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RadioListTile<String>(
                      title: const Text('Tuesday'),
                      value: 'Tuesday',
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value.toString();
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RadioListTile<String>(
                      title: const Text('Wednesday'),
                      value: 'Wednesday',
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value.toString();
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),

                /// SWITCH PICKER
                const Text(
                  "Switch Picker",
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
                      height: 56,
                      color: Theme.of(context).hintColor.toMaterialColor().shade50,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              isSwitched ? "Light On" : "Light Off",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.inverseSurface,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                /// SLIDER PICKER
                const Text(
                  "Slider Picker",
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
                              sliderValue.toString(),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  child:
                    Slider(
                      value: sliderValue,
                      label: sliderValue.round().toString(),
                      max: 1,
                      divisions: 10,
                      onChanged: (double value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
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

