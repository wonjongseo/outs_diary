// import 'package:date_picker_timeline/date_picker_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ours_log/common/theme/theme.dart';

// import 'package:permission_handler/permission_handler.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   DateTime _selectedDateTime = DateTime.now();
//   @override
//   void initState() {
//     super.initState();

//     _permissionWithNotification();
//   }

//   void _permissionWithNotification() async {
//     await [Permission.notification].request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _appTaskBar(),
//             _addDateBar(),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }

//   AppBar _appBar() {
//     return AppBar(
//       elevation: 0,
//       leading: GestureDetector(
//         onTap: () {},
//         child: Icon(
//           Icons.wb_sunny_outlined,
//           size: 20,
//         ),
//       ),
//       actions: [
//         CircleAvatar(),
//         SizedBox(width: 20),
//       ],
//     );
//   }

//   Container _addDateBar() {
//     return Container(
//       margin: const EdgeInsets.only(top: 20, left: 20),
//       child: DatePicker(
//         DateTime.now(),
//         height: 100,
//         width: 80,
//         initialSelectedDate: _selectedDateTime,
//         selectedTextColor: Colors.white,
//         dateTextStyle: TextStyle(
//             fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
//         dayTextStyle: TextStyle(
//             fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
//         monthTextStyle: TextStyle(
//             fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
//         onDateChange: (selectedDate) {
//           _selectedDateTime = selectedDate;
//           setState(() {});
//         },
//       ),
//     );
//   }

//   _appTaskBar() {
//     return Container(
//       margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   DateFormat.yMMMMd().format(DateTime.now()),
//                   style: subHeadingStyle,
//                 ),
//                 Text(
//                   'Today',
//                   style: headingStyle,
//                 ),
//               ],
//             ),
//           ),
//           // CustomButton(
//           //   onTap: () async {
//           //     await Get.to(() => const AddTaskView());
//           //     _taskController.getTasks();
//           //   },
//           //   label: '+ Add Task',
//           // )
//         ],
//       ),
//     );
//   }

//   _bottomSheetButton({
//     required String label,
//     required Function()? onTap,
//     required Color color,
//     bool isClose = false,
//     // BuildContext context,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4),
//         height: 55,
//         width: MediaQuery.of(context).size.width * .9,
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: isClose
//                 ? Get.isDarkMode
//                     ? Colors.grey[600]!
//                     : Colors.grey[300]!
//                 : color,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           color: isClose ? Colors.transparent : color,
//         ),
//         child: Center(
//           child: Text(
//             label,
//           ),
//         ),
//       ),
//     );
//   }

//   void _showBottomSheet(BuildContext context, Task task) {
//     Get.bottomSheet(
//       Container(
//         width: double.infinity,
//         padding: EdgeInsets.only(top: 4),
//         height: task.isCompleted == 1
//             ? MediaQuery.of(context).size.height * .24
//             : MediaQuery.of(context).size.height * .32,
//         color: Colors.white,
//         child: Column(
//           children: [
//             Container(
//               height: 6,
//               width: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
//               ),
//             ),
//             const Spacer(),
//             _bottomSheetButton(
//               label: 'Delete Completed',
//               onTap: () {
//                 Get.back();
//               },
//               color: Colors.red[300]!,
//             ),
//             SizedBox(height: 20),
//             _bottomSheetButton(
//               label: 'Close',
//               isClose: true,
//               onTap: () {
//                 Get.back();
//               },
//               color: Colors.red[300]!,
//             ),
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }
