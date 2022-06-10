class AppUser {
  String uid = '';
  String email = '';
  String nickName = '';
  List<String> friends = List.of(Iterable.empty());
  // List<String> animals = ["0"];
  // int stars = 0;
  // List<String> tags = List.of(Iterable.empty());
  // List<String> townAchievements = [];

  AppUser({
    //required this.uid,
    required this.email,
    required this.nickName,
    //required this.friends,
    //required this.animals });
  });

  void setEmail(String email) {
    this.email = email;
  }

  void setNickName(String nickName) {
    this.nickName = nickName;
  }
/*
  void addFriend(String friend) {
    this.friends.add(friend);
  }
  void addAnimal(String animalId) {
    this.animals.add(animalId);
  }
  */

}