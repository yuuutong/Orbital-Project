class AppUser {
  String uid = '';
  String email = '';
  String nickName = '';
  List<String> friends = List.of(Iterable.empty());
  // index is the flower code, elem at that index is the num of that particular flower
  List<String> flowers = ['1', '0', '0', '0']; // the user only has 1 sunflower at the start
  int coins = 200;
  int numOfDays = 2;
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