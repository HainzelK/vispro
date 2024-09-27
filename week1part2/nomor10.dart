

void main(List<String> args) {
List<String> orang = ["A", "B", "C", "D", "E"];

int i = 0;
    while (i < orang.length){
      int loket = 0;
        if(i % 2 == 0) {
           loket = 1;
        }  
        else{
           loket = 2;
        } 
      print("Nasabah ${orang[i]} dilayani di loket $loket");
      i++;
    }



}