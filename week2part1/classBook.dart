class Book {
  String title;
  String author;
  int year;

  Book(this.title, this.author, this.year);  
}

class Library {
  List<Book> listBuku = [];  

  void addBook(Book book) {
    listBuku.add(book);  
  }

  void remove(String title) {
    listBuku.removeWhere((book) => book.title == title); 
  }

  void displayBooks() {
    if (listBuku.isEmpty) {
      print("No books in the library.");
    } else {
      for (var book in listBuku) {
        print("Title: ${book.title}, Author: ${book.author}, Year: ${book.year}");
      }
    }
  }
}