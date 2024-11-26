import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:batterymonitor/ui/theme/theme.dart';
import 'package:batterymonitor/state/authState.dart';
import 'package:batterymonitor/navigator/constants.dart';
import 'package:batterymonitor/widgets/circularImage.dart';
import 'package:batterymonitor/widgets/customWidgets.dart';
import 'package:batterymonitor/ui/pages/Auth/welcomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:batterymonitor/widgets/url_text/customUrlText.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Widget _menuHeader() {
    final state = context.watch<AuthState>();
    if (state.userModel == null) {
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 200, minHeight: 100),
        child: Center(
          child: Text(
            'Login to continue',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ).ripple(
        () {
          _logOut();
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => WelcomePage())),
          );
        },
      );
    } else {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              width: 57,
              height: 57,
              margin: EdgeInsets.only(left: 17, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                border: Border.all(width: 2, color: Colors.white),
                image: DecorationImage(
                  image: customAdvanceNetworkImage(
                    state.userModel!.profilePic ?? Constants.profp,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                //Navigator.push(
                //  context,
                //  ProfilePage.getRoute(profileId: state.userModel!.userId!),
                //);
              },
              title: Center(
                child: Row(
                  children: <Widget>[
                    UrlText(
                      text: state.userModel!.displayName ?? "",
                      style: TextStyles.onPrimaryTitleText.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 3),
                    state.userModel!.isVerified ?? false
                        ? customIcon(
                            context,
                            icon: FontAwesomeIcons.circleCheck,
                            isIcon: true,
                            iconColor: AppColor.primary,
                            size: 18,
                            paddingIcon: 3,
                          )
                        : SizedBox(width: 0),
                  ],
                ),
              ),
              subtitle: customText(
                state.userModel!.userName,
                style: TextStyles.onPrimarySubTitleText.copyWith(
                  fontSize: 15,
                  color: AppColor.darkGrey,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  ListTile _menuListRowButton(String title,
      {Function? onPressed, IconData? icon, bool isEnable = false}) {
    return ListTile(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      leading: icon == null
          ? null
          : Padding(
              padding: EdgeInsets.only(top: 5),
              child: customIcon(
                context,
                icon: icon,
                size: 25,
                iconColor: isEnable ? Colors.black : AppColor.lightGrey,
              ),
            ),
      title: customText(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          color: isEnable ? AppColor.secondary : AppColor.lightGrey,
        ),
      ),
    );
  }

  Positioned _footer() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 6),
          Row(
            children: <Widget>[
              SizedBox(width: 10, height: 45),
              SizedBox(width: 0, height: 45),
            ],
          ),
        ],
      ),
    );
  }

  void _logOut() {
    final state = Provider.of<AuthState>(context, listen: false);
    Navigator.pop(context);
    state.logoutCallback();
  }

  void _navigateTo(String path) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed('/$path');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(),
              child: Column(
                children: <Widget>[
                  Container(child: _menuHeader()),
                  SizedBox(height: 75),
                  _menuListRowButton(
                    'Premium',
                    icon: FontAwesomeIcons.boltLightning,
                    isEnable: true,
                    onPressed: () {
                      _navigateTo('Premium');
                    },
                  ),
                  SizedBox(height: 15),
                  _menuListRowButton(
                    'Help Center',
                    icon: FontAwesomeIcons.handshake,
                    isEnable: true,
                    onPressed: () {
                      _navigateTo('Help');
                    },
                  ),
                  SizedBox(height: 15),
                  _menuListRowButton(
                    'Settings and privacy',
                    icon: FontAwesomeIcons.gear,
                    isEnable: true,
                    onPressed: () {
                      _navigateTo('SettingsAndPrivacyPage');
                    },
                  ),
                  SizedBox(height: 15),
                  _menuListRowButton(
                    'Logout',
                    isEnable: true,
                    onPressed: _logOut,
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                  ),
                ],
              ),
            ),
            _footer()
          ],
        ),
      ),
    );
  }
}
