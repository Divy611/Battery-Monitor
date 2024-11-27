import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:batterymonitor/ui/pages/common/header.dart';
import 'package:batterymonitor/ui/pages/common/sidebar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: Header(title: 'Welcome, User!'),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              readingTile(context, 'Battery', 0.64, Colors.green.shade700),
              readingTile(
                  context, 'Charge Cycles', 0.90, Colors.green.shade700),
              readingTile(context, 'Temparature', 0.95, Colors.red.shade700),
            ],
          ),
        ),
      ),
    );
  }

  Widget readingTile(
      BuildContext context, String title, double percent, Color colour) {
    return Container(
      padding: EdgeInsets.all(17.5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(width: 0.5, color: Colors.grey.shade400),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('', style: GoogleFonts.montserrat(fontSize: 17)),
            ],
          ),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                CircularPercentIndicator(
                  radius: 65,
                  lineWidth: 5,
                  percent: percent,
                  progressColor: colour,
                  center: Text((percent * 100).toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
