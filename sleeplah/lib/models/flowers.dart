class Flower {
  String id;
  String name;
  int num;

  Flower(this.id, this.name, this.num);

  int getNum() {
    return num;
  }
}

List<Flower> FlowerList = [
  Flower("0", "Sunflower", 1),
  Flower("1", "Rose", 0),
  Flower("2", "Daisy", 0),
  Flower("3", "Lilac", 0),
];