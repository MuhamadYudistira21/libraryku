import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text =
          DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }
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
                controller: borrowDateController,
                readOnly: true,
                onTap: () => _selectDate(borrowDateController),
                decoration: const InputDecoration(
                  labelText: 'Tanggal Pinjam',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: returnDateController,
                readOnly: true,
                onTap: () => _selectDate(returnDateController),
                decoration: const InputDecoration(
                  labelText: 'Tanggal Kembali',
                  suffixIcon: Icon(Icons.calendar_today),
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