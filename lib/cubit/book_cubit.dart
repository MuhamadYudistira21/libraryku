import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/book_model.dart';
import '../services/database_service.dart';
import 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  final DatabaseService databaseService =
      DatabaseService.instance;

  Future<void> showBooks() async {
    try {
      emit(BookLoading());

      final books =
      await databaseService.getBooks();

      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> addBook(
      BookModel book) async {
    await databaseService.insertBook(
      book,
    );

    showBooks();
  }

  Future<void> updateBook(
      BookModel book) async {
    await databaseService.updateBook(
      book,
    );

    showBooks();
  }

  Future<void> deleteBook(
      int id) async {
    await databaseService.deleteBook(
      id,
    );

    showBooks();
  }
}