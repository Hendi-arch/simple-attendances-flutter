import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_attendances/core/services/hive_db_service.dart';
import 'package:simple_attendances/core/stores/home/home_store.dart';
import 'package:simple_attendances/views/helpers/gap.dart';
import 'package:simple_attendances/views/widgets/box_card.dart';
import 'package:simple_attendances/views/widgets/custom_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = HomeStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  BoxCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: "Your pin point is:",
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(2, 2),
                                ),
                              ],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          tenPx,
                          ValueListenableBuilder<Box<dynamic>>(
                            valueListenable: homeStore.userStore.userBox!.listenable(),
                            builder: (_, box, __) {
                              return CustomTextWidget(
                                maxLines: 6,
                                fontSize: 15,
                                textOverflow: TextOverflow.ellipsis,
                                textStyle: const TextStyle(fontWeight: FontWeight.w500),
                                text: homeStore.userStore.getCurrentPinLocation()?.address ?? 'You have not set your pin point yet.',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    boxConstraints: const BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 5,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    boxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  thirtySixPx,
                  BoxCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: "Your attend is:",
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(2, 2),
                                ),
                              ],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          tenPx,
                          StreamBuilder<BoxEvent>(
                            stream: homeStore.attendancesBox.watch(),
                            builder: (_, snapshot) {
                              if (homeStore.attendancesBox.isNotEmpty) {
                                return CustomTextWidget(
                                  maxLines: 6,
                                  fontSize: 15,
                                  textOverflow: TextOverflow.ellipsis,
                                  textStyle: const TextStyle(fontWeight: FontWeight.w500),
                                  text: 'Name: ${homeStore.attendancesBox.get(HiveDbService.constAttend)?.name} \n'
                                      'Date: ${homeStore.attendancesBox.get(HiveDbService.constAttend)?.timestamp}',
                                );
                              }
                              return const CustomTextWidget(
                                maxLines: 6,
                                fontSize: 15,
                                textOverflow: TextOverflow.ellipsis,
                                textStyle: TextStyle(fontWeight: FontWeight.w500),
                                text: 'No attendances yet',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    boxConstraints: const BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 5,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    boxWidth: MediaQuery.of(context).size.width * 0.8,
                  )
                ],
              ),
            ),
          ),
          tenPx,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Add Attendance'),
                  onPressed: () => homeStore.addAttendances(context),
                ),
                ElevatedButton(
                  child: const Text('Set Pin Location'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () => homeStore.goToLocationScreen(context),
                ),
                ElevatedButton(
                  child: const Text('Sign Out'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () => homeStore.signOut(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
