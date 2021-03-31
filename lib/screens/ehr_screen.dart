import 'package:demo_altrumo/screens/ehr_myfiles_screen.dart';
import 'package:demo_altrumo/screens/ehr_shared_files.dart';
import 'package:demo_altrumo/screens/ehr_patient_recordscreen.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/ehr_patients_records_screen.dart';

class EhrScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: Text("EHR"),
    //         backgroundColor: Colors.blue,
    //         elevation: 0,
    //         bottom: TabBar(
    //             labelColor: Colors.blue,
    //             unselectedLabelColor: Colors.white,
    //             indicatorSize: TabBarIndicatorSize.label,
    //             indicator: BoxDecoration(
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(10),
    //                     topRight: Radius.circular(10)),
    //                 color: Colors.white),
    //             tabs: [
    //               Tab(
    //                 child: Align(
    //                   alignment: Alignment.center,
    //                   child: Text("APPS"),
    //                 ),
    //               ),
    //               Tab(
    //                 child: Align(
    //                   alignment: Alignment.center,
    //                   child: Text("MOVIES"),
    //                 ),
    //               ),
    //
    //             ]
    //         ),
    //       ),
    //       body: TabBarView(children: [
    //         EhrSharedScreen(),
    //         EhrMyFilesScreen()
    //       ]),
    //     )
    // );
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Patient Health Record"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: Material(
                borderOnForeground: true,
                child: TabBar(
                  labelColor: Colors.blue,
                  indicatorColor: Colors.blue,
                  labelPadding: EdgeInsets.all(8.0),
                  tabs: [
                    Tab(text: "Patient Records",),
                    Tab(text: "Shared Files"),
                    Tab(text: "My Files"),

                  ],
                ),
              ),
            ),
          ),
          // drawer: Drawer(
          //   child: MainDrawer(),
          // ),
          body: TabBarView(
            children: [
              EhrPatientsRecordsScreen(),
              EhrSharedScreen(),
              EhrMyFilesScreen(),


            ],
          ),
        ),
      ),
    );
  }
}
