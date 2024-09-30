class Vehicle {
  String? name;
  int? speed;
  void move(){
    if (speed!<30){
      print("slow");
    }
    else if(speed!>60){
      print("fast");
    }    
    else if(speed!<60){
      print("normal");
  }

  }
}

class Car extends Vehicle {
  @override
  void move() {
    if (speed!<30){
      print("mobil lambat");
    }
    else if(speed!>60){
      print("mobil cepat");
    }    
    else if(speed!<60){
      print("mobil normal");
  }
}
}

class Bike extends Vehicle {
  @override
  void move() {
    if (speed!<30){
      print("motor lambat");
    }
    else if(speed!>60){
      print("motor cepat");
    }    
    else if(speed!<60){
      print("motor normal");
  }
  }
}