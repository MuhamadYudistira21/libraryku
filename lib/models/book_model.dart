class BookModel {
  final int? id;
  final String title;
  final String author;
  final String borrower;
  final String borrowDate;
  final String returnDate;
  final String status;

  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.borrower,
    required this.borrowDate,
    required this.returnDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'borrower': borrower,
      'borrowDate': borrowDate,
      'returnDate': returnDate,
      'status': status,
    };
  }

  factory BookModel.fromMap(
      Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      borrower: map['borrower'],
      borrowDate: map['borrowDate'],
      returnDate: map['returnDate'],
      status: map['status'],
    );
  }
}