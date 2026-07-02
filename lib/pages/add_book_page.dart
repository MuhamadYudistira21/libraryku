import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/book_cubit.dart';
import '../models/book_model.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() =>
      _AddBookPageState();
}

class _AddBookPageState
    extends State<AddBookPage> {
  final titleController =
  TextEditingController();

  final authorController =
  TextEditingController();

  final borrowerController =
  TextEditingController();

  final borrowDateController =
  TextEditingController();

  final returnDateController =
  TextEditingController();

  String status = 'Tersedia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Buku',
        ),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller:
                titleController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Judul Buku',
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller:
                authorController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Penulis',
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller:
                borrowerController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Peminjam',
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller:
                borrowDateController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Tanggal Pinjam',
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller:
                returnDateController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Tanggal Kembali',
                ),
              ),

              const SizedBox(height: 10),

              DropdownButton<String>(
                value: status,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'Tersedia',
                    child:
                    Text('Tersedia'),
                  ),
                  DropdownMenuItem(
                    value: 'Dipinjam',
                    child:
                    Text('Dipinjam'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  final book = BookModel(
                    title:
                    titleController.text,
                    author:
                    authorController.text,
                    borrower:
                    borrowerController
                        .text,
                    borrowDate:
                    borrowDateController
                        .text,
                    returnDate:
                    returnDateController
                        .text,
                    status: status,
                  );

                  context
                      .read<BookCubit>()
                      .addBook(book);

                  Navigator.pop(
                    context,
                  );
                },
                child: const Text(
                  'Simpan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}