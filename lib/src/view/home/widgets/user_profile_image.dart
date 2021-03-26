import 'package:flutter/material.dart';

// added dependencies
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class UserProfileImage extends StatelessWidget {
  final String _profileImageUrl;
  final double _radius;
  UserProfileImage(this._profileImageUrl, this._radius);
  @override
  Widget build(BuildContext context) {
    if (_profileImageUrl == null) {
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
        '$_profileImageUrl' + '&time=${DateTime.now().toString()}',
        radius: _radius,
        borderWidth: 0,
        backgroundColor: Colors.grey,
        elevation: 0,
        cacheImage: true,
      );
  }
}
