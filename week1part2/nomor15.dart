void main() {
  int jumlahTugas = 6;
  int tugasSeles = 0;

  while (tugasSeles < jumlahTugas) {
    int index = tugasSeles;
      String huruf = String.fromCharCode(index + 65);
      print('Tugas $huruf');
      tugasSeles++;
  }
}