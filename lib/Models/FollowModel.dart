class FollowModel {
  // uidUser is the person who sent the follow request
  // uidUserToFollow is the user at the receiveig end
  // userName, userImage, userProfession is the details of the recieving user
  // status can also be added now

  String uidUserFollower;
  String nameUserFollower;
  String imageUserFollower;
  String professionUserFollower;
  String uidUserFollowing;
  String nameUserFollowing;
  String imageUserFollowing;
  String professionUserFollowing;

  FollowModel(
      {this.imageUserFollower,
      this.nameUserFollower,
      this.professionUserFollower,
      this.professionUserFollowing,
      this.nameUserFollowing,
      this.uidUserFollower,
      this.uidUserFollowing,
      this.imageUserFollowing});

  Map<String, dynamic> toMapFollowing() {
    return {
      'uidUserFollower': uidUserFollower,
      'nameUserFollower': nameUserFollower,
      'imageUserFollower': imageUserFollower,
      'professionUserFollower': professionUserFollower,
      'uidUserFollowing': uidUserFollowing,
      'nameUserFollowing': nameUserFollowing,
      'imageUserFollowing': imageUserFollowing,
      'professionUserFollowing': professionUserFollowing,
    };
  }

  FollowModel fromMap(snap) {
    return FollowModel(
        uidUserFollower: snap['uidUserFollower'],
        uidUserFollowing: snap['uidUserFollowing'],
        nameUserFollower: snap['nameUserFollower'],
        nameUserFollowing: snap['nameUserFollowing'],
        imageUserFollower: snap['imageUserFollower'],
        imageUserFollowing: snap['imageUserFollowing'],
        professionUserFollower: snap['professionUserFollower'],
        professionUserFollowing: snap['professionUserFollowing']);
  }
}
