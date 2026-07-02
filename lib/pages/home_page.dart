import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/book_cubit.dart';
import '../cubit/book_state.dart';
import 'add_book_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookCubit>().showBooks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('LibraryKu'),
      ),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BookLoaded) {
            if (state.books.isEmpty) {
              return const Center(
                child: Text('Belum ada buku'),
              );
            }

            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];

                return Card(
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text(
                      "${book.author}\n${book.status}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<BookCubit>()
                            .deleteBook(
                          book.id!,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }

          if (state is BookError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton:
      FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddBookPage(),
            ),
          );
        },
      ),
    );
  }
}