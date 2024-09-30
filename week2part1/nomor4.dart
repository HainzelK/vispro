import 'dart:io';
import 'classBook.dart';


void main(List<String> args) {
  var library = Library();

  var book1 = Book("Book 1", "Orang", 2021);
  library.addBook(book1);  

  while (true) {
    print("Pilih:\n1. Tambah Buku\n2. Remove Buku\n3. Cek Buku\n4. Exit");
    int? pilih = int.parse(stdin.readLineSync()!);
    print('==================================================');
    switch (pilih) {
      case 1:
        print("Tambah buku: ");
        String title = stdin.readLineSync()!;
        print("Penulis: ");
        String author = stdin.readLineSync()!;
        print("Tahun terbit: ");
        int year = int.parse(stdin.readLineSync()!);

        var newBook = Book(title, author, year);
        library.addBook(newBook);
        break;

      case 2:
        print("Buku yang ingin dihapus: ");
        String titleToRemove = stdin.readLineSync()!;
        library.remove(titleToRemove);
        break;

      case 3:
        print("List Buku:");
        library.displayBooks();
        break;
      case 4 :
        return;

    }
  }
}
