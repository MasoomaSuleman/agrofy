import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_achievements.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_experience.dart';
class OtherUserProfessionalDetails extends StatelessWidget {
  final List achievementList;
  final List experienceList;
  OtherUserProfessionalDetails({
    @required this.achievementList,
    @required this.experienceList
    });
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        OtherUserExperience(
          experienceList: experienceList,
        ),
        OtherUserAchievement(achievementList: achievementList)
      ],
    );
  }
}