import 'package:flutter/material.dart';
import '../models/data_tempat_makan.dart';
import '../services/serv_tempat_makan.dart';

class FormPage extends StatefulWidget {
  final TempatMakan? tempatMakan;

  const FormPage({super.key, this.tempatMakan});

  @override
  State<FormPage> createState() => _FormPageState();
}

bool isLoading = false;

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TempatMakanService service = TempatMakanService();

  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController ratingController;

  final List<String> kategoriList = [
    "Bakso",
    "Ayam",
    "Seafood",
    "Coffee",
    "Mie",
    "Sate",
    "Fast Food",
  ];

  String? selectedKategori;

  @override
  void initState() {
    super.initState();

    namaController =
        TextEditingController(text: widget.tempatMakan?.nama ?? "");
    alamatController =
        TextEditingController(text: widget.tempatMakan?.alamat ?? "");
    ratingController = TextEditingController(
        text: widget.tempatMakan?.rating.toString() ?? "");

    selectedKategori = widget.tempatMakan?.kategori;
  }

  InputDecoration customInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Future<void> simpanData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      TempatMakan data = TempatMakan(
        id: widget.tempatMakan?.id,
        nama: namaController.text,
        alamat: alamatController.text,
        kategori: selectedKategori ?? "Lainnya",
        rating: double.parse(ratingController.text),
      );
      try {
        if (widget.tempatMakan == null) {
          await service.tambahData(data);
        } else {
          await service.updateData(widget.tempatMakan!.id!, data);
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tempatMakan == null
            ? "Tambah Tempat Makan"
            : "Edit Tempat Makan"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: customInput("Nama Tempat", Icons.restaurant),
                validator: (value) =>
                    value == null || value.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: alamatController,
                decoration: customInput("Alamat", Icons.location_on),
                validator: (value) =>
                    value == null || value.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedKategori,
                decoration: customInput("Kategori", Icons.fastfood),
                items: kategoriList
                    .map((kategori) => DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedKategori = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Pilih kategori" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ratingController,
                keyboardType: TextInputType.number,
                decoration: customInput("Rating (1-5)", Icons.star),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Rating wajib diisi";
                  }
                  final rating = double.tryParse(value);
                  if (rating == null || rating < 1 || rating > 5) {
                    return "Rating harus 1-5";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: simpanData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.all(14),
                  ),
                  child: isLoading 
                  ? const CircularProgressIndicator(color: Colors.white,) 
                  : const Text("Simpan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}