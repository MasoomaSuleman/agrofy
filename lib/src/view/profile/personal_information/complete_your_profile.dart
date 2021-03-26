import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// added dependencees
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/change_profile_photo.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/personal_information.dart';

//app dependencies
import 'package:kisaanCorner/utils/SizeConfig.dart';
import 'package:kisaanCorner/src/view/profile/widgets/custom_button.dart';
import '../stepper/stepper_flow.dart';

class CompleteYourProfilePage extends StatefulWidget {
  final User userModel;
  final Function goToAddMoreDetailsPage;
  final GlobalKey<FormState> personalInformationFormKey;
  CompleteYourProfilePage(
      {this.goToAddMoreDetailsPage,
      this.userModel,
      this.personalInformationFormKey});
  @override
  _CompleteYourProfilePageState createState() =>
      _CompleteYourProfilePageState();
}

class _CompleteYourProfilePageState extends State<CompleteYourProfilePage> {
  final ScrollController completeYourProfileScrollController =
      ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    completeYourProfileScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
          controller: completeYourProfileScrollController,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              StepperOne(),
              SizedBox(
                height: 10.0,
              ),
              ChangeProfilePhoto(
                  personalInformationModel:
                      widget.userModel.personalInformation,
                  defaultProfileImageUrl:
                      widget.userModel?.personalInformation?.profileImageUrl),
              SizedBox(
                height: 20,
              ),
              PersonalInformation(
                completeYourProfileScrollController:
                    completeYourProfileScrollController,
                personalInformationModel: widget.userModel.personalInformation,
                personalInformationFormKey: widget.personalInformationFormKey,
                signInMethod: widget.userModel.signInMethod,
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                text: 'Done',
                press: () {
                  // on press for this button
                  if (widget.personalInformationFormKey.currentState
                      .validate()) {
                    // close the keyboard
                    widget.personalInformationFormKey.currentState.save();
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    widget.goToAddMoreDetailsPage();
                  } else {
                    // to top of the screen
                    completeYourProfileScrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  }
                },
              ),
              SizedBox(
                height: 50,
              )
            ],
          )),
    );
  }
}
