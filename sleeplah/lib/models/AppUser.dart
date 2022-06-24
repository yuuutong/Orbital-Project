class AppUser {
  String uid = '';
  String email = '';
  String nickName = '';
  List<String> friends = List.of(Iterable.empty());
  List<String> flowers = ["0"]; // the user only has sunflower at the start
  int coins = 0;
  int numOfDays = 0;
  // List<String> tags = List.of(Iterable.empty());
  // List<String> townAchievements = [];

  AppUser({
    //required this.uid,
    required this.email,
    required this.nickName,
    //required this.friends,
    //required this.coins 
  });

  void setEmail(String email) {
    this.email = email;
  }

  void setNickName(String nickName) {
    this.nickName = nickName;
  }
}