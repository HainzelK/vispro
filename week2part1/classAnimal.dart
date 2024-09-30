class Animal {
  void sound(){
    print('Bersuara');
  }

  void eat(){
    print('lagi makan');
  }
}

class Dog extends Animal {
  @override
  void sound() {
    print("Gongogngongong");
  }

  @override
  void eat() {
    print("Makan daging");
  }
}
class Cat extends Animal {
  @override
  void sound() {
    print("mawmawmawmm");
  }

  @override
  void eat() {
    print("Makan ikan");
  }
}