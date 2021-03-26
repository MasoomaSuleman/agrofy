import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kisaanCorner/src/model/user/personal_information/personal_information_model.dart';
import 'package:kisaanCorner/src/model/user/other_details/achievment_model.dart';
import 'package:kisaanCorner/src/model/user/other_details/experience_model.dart';
import 'package:kisaanCorner/src/network/save_user_profile_to_firebase.dart';

class User extends ChangeNotifier {
  PersonalInformationModel personalInformation = PersonalInformationModel();
  List<Achievements> achievementList = [Achievements()];
  List<Experience> experienceList = [Experience()];
  // other essential infoermation about the user
  // add other user details like counts and sign in details
  String userId = '123456';
  int followersCount = 0;
  int followingCount = 0;
  int questionsCount = 0;
  int answersCount = 0;
  List<String> likeList = [];
  List<String> bookmarkList = [];
  String signInMethod;
  List<String> deviceTokensList = [''];
  //details for ui and other purposes
  bool isError = false;
  User();
  SaveUserProfileToFirebase _saveUserProfileToFirebase =
      SaveUserProfileToFirebase();

  Future<bool> save(
      User userModelToSave, BuildContext context, GlobalKey key) async {
    isError = await _saveUserProfileToFirebase.saveNewUserProfileToFirebase(
        userModelToSave, context);
    if (!isError) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> editPersonalInformation(
      {PersonalInformationModel personalInformationModel,
      BuildContext context}) async {
    bool _isSuccess =
        await _saveUserProfileToFirebase.savePersonalInformationToFirebase(
            context: context,
            userId: userId,
            personalInformationModel: personalInformationModel);
    if (_isSuccess)
      return true;
    else
      return false;
  }

  Future<bool> editAchievment(Achievements ach, BuildContext context,
      User currentUser, int index, Achievements oldach) async {
    currentUser.achievementList[index] = ach;
    achievementList = currentUser.achievementList;
    bool _isSuccess =
        await _saveUserProfileToFirebase.addAch(achievementList, userId);
    if (_isSuccess) {
      notifyListeners();
      return true;
    } else {
      currentUser.achievementList[index] = oldach;
      achievementList = currentUser.achievementList;
      notifyListeners();
      return false;
    }
  }
  Future<bool> deleteAchievment( BuildContext context,
      User currentUser, int index, Achievements oldach) async {
    currentUser.achievementList.removeAt(index);
    achievementList = currentUser.achievementList;
    bool _isSuccess =
        await _saveUserProfileToFirebase.addAch(achievementList, userId);
    if (_isSuccess) {
      notifyListeners();
      return true;
    } else {
      currentUser.achievementList.insert(index, oldach);
      achievementList = currentUser.achievementList;
      notifyListeners();
      return false;
    }
  }
  Future<bool> deleteExperience(BuildContext context,
      User currentUser, int index, Experience oldexp) async {
    currentUser.experienceList.removeAt(index);
    experienceList = currentUser.experienceList;
    bool _isSuccess =
        await _saveUserProfileToFirebase.addExp(experienceList, userId);
    if (_isSuccess) {
      notifyListeners();
      return true;
    } else {
      currentUser.experienceList.insert(index, oldexp);
      experienceList = currentUser.experienceList;
      notifyListeners();
      return false;
    }
  }
  Future<bool> editExperience(Experience exp, BuildContext context,
      User currentUser, int index, Experience oldexp) async {
    currentUser.experienceList[index] = exp;
    experienceList = currentUser.experienceList;
    bool _isSuccess =
        await _saveUserProfileToFirebase.addExp(experienceList, userId);
    if (_isSuccess) {
      notifyListeners();
      return true;
    } else {
      currentUser.experienceList[index] = oldexp;
      experienceList = currentUser.experienceList;
      notifyListeners();
      return false;
    }
  }

  Future<bool> addnewExperience(
      Experience exp, BuildContext context, User currentUser) async {
    currentUser.experienceList.add(exp);
    experienceList = currentUser.experienceList;
    bool _isSuccess =
        await _saveUserProfileToFirebase.addExp(experienceList, userId);
    if (_isSuccess) {
      notifyListeners();
      return true;
    } else {
      currentUser.experienceList.removeLast();
      experienceList = currentUser.experienceList;
      notifyListeners();
      return false;
    }
  }
//
//  Future<bool> addExperience(User exp) async {
//    isError = await _saveUserProfileToFirebase.addExp(exp);
//    if (!isError) {
//      notifyListeners();
//      return true;
//    } else {
//      notifyListeners();
//      return false;
//    }
//  }

  Future<bool> addnewAchievment(
      Achievements ach, BuildContext context, User currentUser) async {
    currentUser.achievementList.add(ach);
    achievementList = currentUser.achievementList;
    bool _isSuccess =
        await _saveUserProfileToFirebase.addAch(achievementList, userId);
    if (_isSuccess) {
      notifyListeners();
      return true;
    } else {
      currentUser.achievementList.removeLast();
      achievementList = currentUser.achievementList;
      notifyListeners();
      return false;
    }
  }

  // bookmarks functions
  void addBookmarkToProvider(String questionId) {
    bookmarkList.add(questionId);
    print(
        "User()''': addBookmarkToProvider(): the new bookmark list is ${bookmarkList.toString()}");
    notifyListeners();
  }

  void removeBookmarkFromProvider(String questionId) {
    bookmarkList.remove(questionId);
    print(
        "User()''': removeBookmarkToProvider(): the new bookmark list is ${bookmarkList.toString()}");
    notifyListeners();
  }
  //like functions
   // bookmarks functions
  void addLikeToProvider(String answerId) {
    likeList.add(answerId);
    print(
        "User()''': addlikeToProvider(): the new like list is ${likeList.toString()}");
    notifyListeners();
  }
  void addFollowingCount(){
    followingCount++;
    print("following added");
    Firestore.instance.collection('userData').document(userId).updateData({
      'followingCount': followingCount
    });
    notifyListeners();
  }
  void subFollowingCount(){
    followingCount--;
    print("following subtracted");
    Firestore.instance.collection('userData').document(userId).updateData({
      'followingCount': followingCount
    });
    notifyListeners();
  }
  void removeLikeFromProvider(String answerId) {
    likeList.remove(answerId);
    print(
        "User()''': removeBookmarkToProvider(): the new like list is ${likeList.toString()}");
    notifyListeners();
  }
  void setNewProfileImage(String newProfileImageString) {
    personalInformation.profileImageUrl = newProfileImageString;
    setInputProfileImageToNull();
    notifyListeners();
  }

  String getOrganizationForQuestionPost() {
    // check if there is an organizaton mention
    // if mentioned then return that
    if (personalInformation.organization != null &&
        personalInformation.organization.length != 0)
      return personalInformation.organization;
    else if (experienceList.isNotEmpty) {
      Experience lastExp = experienceList.last;
      return lastExp.companyName;
    }
    return null;
    // else check if an experince is added
    // if added then return the company from that
    // else return null
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': personalInformation.fullName,
      'email': personalInformation.email,
      'profession': personalInformation.profession,
      'phoneNumber': personalInformation.phoneNumber,
      'organization': personalInformation.organization,
      'address': personalInformation.address,
      'website': personalInformation.website,
      'aboutMe': personalInformation.aboutMe,
      'profileImageUrl': personalInformation.profileImageUrl,
      'userId': userId,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'questionsCount': questionsCount,
      'answersCount': answersCount,
      'likeList': likeList.map((e) => e).toList(),
      'bookmarkList': bookmarkList.map((e) => e).toList(),
      'signInMethod': signInMethod,
      'achievementList': achievementList.map((e) => e.toJson()).toList(),
      'experienceList': experienceList.map((e) => e.toJson()).toList(),
      'deviceTokenList': deviceTokensList.map((e) => e).toList()
    };
  }

  void fromSnap(DocumentSnapshot snap) {
    personalInformation = PersonalInformationModel.fromSnapshot(snap);
    userId = snap.data["userId"];
    followersCount =
        (snap.data["followersCount"] == null) ? 0 : snap.data["followersCount"];
    followingCount =
        (snap.data["followingCount"] == null) ? 0 : snap.data["followingCount"];
    questionsCount =
        (snap.data["questionsCount"] == null) ? 0 : snap.data["questionsCount"];
    answersCount =
        (snap.data["answersCount"] == null) ? 0 : snap.data["answersCount"];
    likeList = (snap.data["likeList"] == null)
        ? []
        : List.from(snap.data["likeList"]?.map((e) => e));
    bookmarkList = (snap.data["bookmarkList"] == null)
        ? []
        : List.from(snap.data["bookmarkList"].map((e) => e));
    signInMethod = snap.data["signInMethod"];
    deviceTokensList = List.from(
      snap.data['deviceTokenList'].map((e) => (e)),
    );
    achievementList = List.from(
      snap.data['achievementList'].map((e) => Achievements.fromJson(e)),
    );
    experienceList = List.from(
        snap.data["experienceList"].map((e) => Experience.fromJson(e)));
    //notifyListeners();
  }

  void fromModel(User user) {
    personalInformation = user.personalInformation;
    userId = user.userId;
    followersCount = user.followersCount;
    followingCount = user.followingCount;
    answersCount = answersCount;
    questionsCount = user.questionsCount;
    likeList = user.likeList;
    bookmarkList = user.bookmarkList;
    signInMethod = user.signInMethod;
    deviceTokensList = user.deviceTokensList;
    achievementList = user.achievementList;
    experienceList = user.experienceList;
    notifyListeners();
  }

  void fromPersonalInformationModel(
      PersonalInformationModel personalInformationModel) {
    personalInformation.phoneNumber = personalInformationModel.phoneNumber;
    personalInformation.fullName = personalInformationModel.fullName;
    personalInformation.profession = personalInformationModel.profession;
    personalInformation.profileImageUrl = personalInformation.profileImageUrl;
    personalInformation.organization = personalInformationModel.organization;
    personalInformation.email = personalInformationModel.email;
    personalInformation.aboutMe = personalInformationModel.aboutMe;
    personalInformation.website = personalInformationModel.website;
    personalInformation.address = personalInformationModel.address;

    notifyListeners();
  }

  void setInputProfileImageToNull() {
    personalInformation.inputProfileImage = null;
    notifyListeners();
  }

  void deleteUserDetails() {
    personalInformation = null;
    achievementList = [Achievements()];
    experienceList = [Experience()];
    userId = '123456';
    followersCount = 0;
    followingCount = 0;
    questionsCount = 0;
    answersCount = 0;
    likeList = [];
    bookmarkList = [];
    signInMethod = null;
    deviceTokensList = [''];
  }

//
//  factory User.fromSnapshot(DocumentSnapshot snap) {
//    return User(
//      personalInformation: PersonalInformationModel.fromSnapshot(snap),
////      fullName: snap.data["fullName"],
////      email: snap.data["email"],
////      profession: snap.data["profession"],
////      phoneNumber: snap.data["phoneNumber"],
////      organization: snap.data["organization"],
////      address: snap.data["address"],
////      website: snap.data["website"],
////      aboutMe: snap.data["aboutMe"],
////      profileImageUrl: snap.data["profileImageUrl"],
//      userId: snap.data["userId"],
//      signInMethod: snap.data["signInMethod"],
//      achievementList: List.from(
//        snap.data['achievementList'].map((e) => Achievements.fromJson(e)),
//      ),
//      experienceList: List.from(
//          snap.data["experienceList"].map((e) => Experience.fromJson(e))),
//    );
//  }

}
