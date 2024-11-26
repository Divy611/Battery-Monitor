import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:batterymonitor/state/appState.dart';
import 'package:batterymonitor/ui/pages/Home/home.dart';
import 'package:batterymonitor/ui/pages/Home/allreadings/readings.dart';
import 'package:batterymonitor/widgets/bottomMenuBar/bottomMenuBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  int pageIndex = 0;
  @override
  void initState() {
    initDynamicLinks();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var state = Provider.of<AppState>(context, listen: false);
        state.setPageIndex = 0;
        initChat();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initChat() {}

  void initDynamicLinks() async {}

  Widget _body() {
    return SafeArea(child: _getPage(Provider.of<AppState>(context).pageIndex));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return AllReadings();
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomMenubar(),
      body: _body(),
    );
  }
}
