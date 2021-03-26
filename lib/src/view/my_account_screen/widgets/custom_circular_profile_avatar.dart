import 'package:flutter/material.dart';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:provider/provider.dart';

import 'package:kisaanCorner/src/model/user/user_model.dart';

class CustomCircularProfileAvatar extends StatelessWidget {
  final double _radius;
  CustomCircularProfileAvatar(this._radius);
  @override
  Widget build(BuildContext context) {
    String profileImageUrl =
        Provider.of<User>(context).personalInformation.profileImageUrl;
    if (profileImageUrl == null) {
      return CircularProfileAvatar(
        '',
        child: Icon(
          Icons.person,
          size: _radius * 0.8,
          color: Colors.grey,
        ),
        radius: _radius,
        borderWidth: 0,
        elevation: 0,
      );
    } else
      return CircularProfileAvatar(
        '$profileImageUrl' + '&time=${DateTime.now().toString()}',
        radius: _radius,
        borderWidth: 0,
        backgroundColor: Colors.grey,
        elevation: 0,
        cacheImage: true,
      );
  }
}
