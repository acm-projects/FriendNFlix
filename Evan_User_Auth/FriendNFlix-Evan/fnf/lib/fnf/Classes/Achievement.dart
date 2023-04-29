import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Achievement {
  static int _count = 0;
  static List<Achievement> achievements = [
    Achievement(
        type: AchievementType.followingCount,
        rarity: AchievementRarity.bronze,
        amountRequired: 1,
    imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.followingCount,
        rarity: AchievementRarity.silver,
        amountRequired: 5,
        imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.followingCount,
        rarity: AchievementRarity.gold,
        amountRequired: 20,
        imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.followerCount,
        rarity: AchievementRarity.bronze,
        amountRequired: 1,
        imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.followerCount,
        rarity: AchievementRarity.silver,
        amountRequired: 10,
        imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.followerCount,
        rarity: AchievementRarity.gold,
        amountRequired: 20,
        imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.postCount,
        rarity: AchievementRarity.bronze,
        amountRequired: 1,
        imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.postCount,
        rarity: AchievementRarity.silver,
        amountRequired: 10,
        imagePath: 'assets/images/logo1.png'),
    Achievement(
        type: AchievementType.postCount,
        rarity: AchievementRarity.gold,
        amountRequired: 20,
        imagePath: 'assets/images/logo1.png')
  ];
  String title;
  String description;
  String imagePath;
  AchievementType type;
  AchievementRarity rarity;
  int amountRequired;
  int id = _count++;
  Achievement(
      {required this.type,
      required this.rarity,
      required this.amountRequired,
        required this.imagePath,
      this.title = "",
      this.description = ""}) {
    // set the title depending on the AchievementType
    switch (type) {
      case AchievementType.followerCount:
        {
          this.title = "Life of the Party";

          // set the description depending on the amountRequired
          if (amountRequired == 1) {
            this.description =
                'Congratulations on your first follower! Too many more!';
          } else {
            this.description =
                'This badge is proof of you reaching ${amountRequired},'
                'followers!';
          }
        }
        break;
      case AchievementType.followingCount:
        {
          this.title = "Social Butterfly";

          // set the description based on the amountRequired
          if(amountRequired == 1){
            this.description = 'You followed your first person! Your feed has received a makeover';
          }else {
            this.description = 'Congratulations! I can\'t even name ${amountRequired} people!';
          }
        }
        break;
      case AchievementType.postCount:
        {
          this.title = "Influencer";

          // set the description based on the amount required
          if(amountRequired == 1){
            this.description = 'Your first post is always special. And what a post it was!';
          } else {
            this.description = '${amountRequired} posts! Thi';
          }
        }
        break;
      default:
        {
          this.title = "DEFAULT TITLE";
        }
        break;
    }
  }

  // call these methods anytime a user might have reached an certain achievement
  // for example, if a user follows someone, call the method below
  static checkForFollowingAchievements() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    final loggedInUser = FirebaseAuth.instance.currentUser;
    // get all followingCount achievements
    List<Achievement> followingAchievements = [];
    for(Achievement achievement in achievements){
      if(achievement.type == AchievementType.followingCount){
        followingAchievements.add(achievement);
      }
    }



    // get the amount of people the user is following, since this will be used
    // to determine if they are eligible for the achievement
    var userRef = db.collection("users").doc(loggedInUser!.email);
    var userSnapshot = await userRef.get();
    var userData = userSnapshot.data();
    List? userFollowingDynamics = userData!["following"];
    if(userFollowingDynamics == null) userFollowingDynamics = [];
    int numFollowing = userFollowingDynamics.length;

    // get the list of the user's achievements, since this will tell us if the
    // user already has an achievement and will prevent us from giving it to
    // them twice
    List? achievementDynamics = userData["achievementIds"];
    if(achievementDynamics == null) achievementDynamics = [];

    Map<int, bool> userAchievements = {};
    for(int id in achievementDynamics){
      userAchievements[id] = true;
    }

    // for every following achievement, check if the user is eligible and does
    // not already have the achievement, if both of these checks pass, give the
    // user the achievement
    for(Achievement achievement in followingAchievements){
      if(userAchievements.containsKey(achievement.id)) {
        print("user already has this achievement!");
        continue;
      }

      if(numFollowing < achievement.amountRequired){
        print(achievement.amountRequired);
        print(numFollowing);
        print("user does not have the amount required for this achievement");
        continue;
      }

      await userRef.update({
        "achievementIds": FieldValue.arrayUnion([achievement.id])
      });
      print("user given achievement!");
      // todo what happens for the UI when a user gets an achievement???
    }

  }

  static checkForFollowerAchievements(var userRef) async {

  }

  static checkForPostsAchievements(var userRef) async {

  }
}

enum AchievementType { followerCount, postCount, followingCount }

AchievementType a = AchievementType.followerCount;

enum AchievementRarity { bronze, silver, gold }
