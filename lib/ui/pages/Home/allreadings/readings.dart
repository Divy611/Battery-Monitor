import 'package:flutter/material.dart';
import 'package:batterymonitor/ui/pages/common/header.dart';

class AllReadings extends StatefulWidget {
  const AllReadings({super.key});
  @override
  State<AllReadings> createState() => _AllReadingsState();
}

class _AllReadingsState extends State<AllReadings> {
  late bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'All Devices'),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
