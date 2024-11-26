import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:batterymonitor/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:batterymonitor/ui/theme/theme.dart';
import 'package:batterymonitor/state/authState.dart';
import 'package:batterymonitor/widgets/customWidgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:batterymonitor/widgets/newWidget/title_text.dart';
import 'package:batterymonitor/widgets/newWidget/rippleButton.dart';

class UserListWidget extends StatelessWidget {
  final List<UserModel> list;
  final String? emptyScreenText;
  final String? emptyScreenSubTileText;
  final Function(UserModel user)? onFollowPressed;
  final bool Function(UserModel user)? isFollowing;
  const UserListWidget({
    super.key,
    this.isFollowing,
    required this.list,
    this.onFollowPressed,
    this.emptyScreenText,
    this.emptyScreenSubTileText,
  });

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    final currentUser = state.userModel!;
    return ListView.separated(
      itemBuilder: (context, index) {
        return UserTile(
          user: list[index],
          currentUser: currentUser,
          isFollowing: isFollowing,
          onTrailingPressed: () {
            if (onFollowPressed != null) {
              onFollowPressed!(list[index]);
            }
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(height: 0);
      },
      itemCount: list.length,
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    this.trailing,
    this.isFollowing,
    required this.user,
    required this.currentUser,
    required this.onTrailingPressed,
  });
  final UserModel user;
  final Widget? trailing;
  final UserModel currentUser;
  final VoidCallback onTrailingPressed;
  final bool Function(UserModel user)? isFollowing;
  String? getBio(String? bio) {
    if (bio != null && bio.isNotEmpty && bio != "Edit profile to update bio") {
      if (bio.length > 100) {
        bio = '${bio.substring(0, 100)}...';
        return bio;
      } else {
        return bio;
      }
    }
    return null;
  }

  bool checkIfFollowing() {
    if (isFollowing != null) {
      return isFollowing!(user);
    }
    if (currentUser.followingList != null &&
        currentUser.followingList!.any((x) => x == user.userId)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFollow = checkIfFollowing();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colorpallete.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {},
            title: Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: context.width * .4),
                  child: TitleText(
                    user.displayName!,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 3),
                user.isVerified!
                    ? customIcon(
                        context,
                        size: 13,
                        isIcon: true,
                        paddingIcon: 3,
                        iconColor: AppColor.primary,
                        icon: FontAwesomeIcons.circleCheck,
                      )
                    : SizedBox(width: 0),
              ],
            ),
            subtitle: Text(user.userName!),
            trailing: RippleButton(
              onPressed: onTrailingPressed,
              splashColor: AppColor.primary,
              borderRadius: BorderRadius.circular(25),
              child: trailing ??
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: isFollow ? 15 : 20,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isFollow ? Colorpallete.primary : Colorpallete.white,
                      border: Border.all(color: Colorpallete.primary, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      isFollow ? 'Following' : 'Follow',
                      style: GoogleFonts.montserrat(
                        color: isFollow ? Colorpallete.white : Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ),
          ),
          getBio(user.bio) == null
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(left: 90),
                  child: Text(getBio(user.bio)!),
                )
        ],
      ),
    );
  }
}
