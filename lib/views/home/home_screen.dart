import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/views/add_diary/add_diary_screen.dart';
import 'package:ours_log/views/add_health/add_health_screen.dart';
import 'package:ours_log/views/background/background1.dart';
import 'package:ours_log/views/background/background2.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = DateTime.now();
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    _selectedDay = now;
    _focusedDay = now;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: selectYearAndMonthDialog,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('yyy년 M월').format(_focusedDay),
                style: boldStyle,
              ),
              SizedBox(width: RS.width10),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: BackGround2(
          widget: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TableCalendar(
                      pageJumpingEnabled: false,
                      locale: isKo ? 'ko' : 'ja',
                      daysOfWeekHeight: 100,
                      headerVisible: false,
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                        setState(() {});
                      },
                      calendarStyle: const CalendarStyle(
                        outsideDaysVisible: false,
                      ),
                      calendarBuilders: CalendarBuilders(
                        prioritizedBuilder: (context, day, focusedDay) {
                          return Column(
                            children: [
                              Container(
                                height: RS.width10 * 4.5,
                                width: RS.width10 * 4.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: day.day > now.day
                                      ? Colors.grey.withOpacity(.15)
                                      : Colors.white,
                                ),
                                margin:
                                    EdgeInsets.only(bottom: RS.height10 / 2),
                              ),
                              if (day == _selectedDay)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: RS.width15),
                                  decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius: BorderRadius.circular(
                                        RS.width15 / 2,
                                      )),
                                  child: Text(
                                    '${day.day}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  '${day.day}',
                                  style: TextStyle(
                                    color: day.day > now.day
                                        ? Colors.grey.withOpacity(.5)
                                        : null,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      firstDay: now.subtract(Duration(days: 365 * 3)),
                      lastDay: now.add(Duration(days: 30)),
                      focusedDay: _focusedDay,
                      rowHeight: 104,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (selectedDay.difference(now).isNegative) {
                          Get.to(
                              () => AddDiaryScreen(selectedDay: selectedDay));
                        } else {
                          print('DO NOT SELECT');
                          return;
                        }
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void selectYearAndMonthDialog() async {
    print('_selectedDay : ${_selectedDay}');
    print('_focusedDay : ${_focusedDay}');

    await Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat('yyy년').format(_focusedDay),
                      style: boldStyle,
                    ),
                    SizedBox(width: RS.width10),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.keyboard_arrow_left),
                    SizedBox(width: RS.width10),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(
                top: RS.height30,
                bottom: RS.height20,
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 15,
                children: List.generate(
                  12,
                  (index) {
                    bool isSelectable = _focusedDay.month > index;

                    return GestureDetector(
                      onTap: () {
                        if (isSelectable) {
                          _focusedDay = DateTime(_focusedDay.year, index - 1);
                        }
                      },
                      child: Container(
                        width: RS.width10 * 6,
                        height: RS.height10 * 3.5,
                        decoration: BoxDecoration(
                          color: index == now.month - 1
                              ? Colors.pinkAccent
                              : isSelectable
                                  ? Colors.grey[300]
                                  : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}월',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: index == _focusedDay.month - 1
                                  ? Colors.white
                                  : isSelectable
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // SizedBox(
            //   height: 20 * 4,
            //   width: 20 * 4,
            //   child: GridView.builder(
            //     gridDelegate:
            //         SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 4,
            //     ),
            //     itemCount: 12,
            //     itemBuilder: (context, index) {
            //       return Container(
            //           height: 20,
            //           width: 20,
            //           padding: EdgeInsets.all(2),
            //           color: Colors.red,
            //           child: Text(index.toString()));
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
