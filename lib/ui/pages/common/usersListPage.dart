import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:batterymonitor/models/user.dart';
import 'package:batterymonitor/ui/theme/theme.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({
    super.key,
    this.pageTitle = "",
    required this.emptyScreenText,
    required this.emptyScreenSubTileText,
    this.userIdsList,
    this.onFollowPressed,
    this.isFollowing,
  });
  final String pageTitle;
  final String emptyScreenText;
  final String emptyScreenSubTileText;
  final bool Function(UserModel user)? isFollowing;
  final List<String>? userIdsList;
  final Function(UserModel user)? onFollowPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorpallete.mystic,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pageTitle,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
      ),
    );
  }
}
