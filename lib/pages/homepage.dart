import 'package:flutter/material.dart';
import 'package:mini_project2_pab/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/data_tempat_makan.dart';
import '../services/serv_tempat_makan.dart';
import 'formpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TempatMakanService service = TempatMakanService();
  late Future<List<TempatMakan>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = service.getData();
  }

  void refreshData() {
    setState(() {
      futureData = service.getData();
    });
  }

  IconData getKategoriIcon(String kategori) {
    switch (kategori.toLowerCase()) {
      case "bakso":
        return Icons.ramen_dining;
      case "coffee":
        return Icons.local_cafe;
      case "seafood":
        return Icons.set_meal;
      case "ayam":
        return Icons.lunch_dining;
      case "mie":
        return Icons.ramen_dining;
      case "sate":
        return Icons.outdoor_grill;
      case "fast food":
        return Icons.fastfood;
      default:
        return Icons.restaurant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🍽 Samarinda Food List"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              MyApp.of(context)?.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<TempatMakan>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final dataList = snapshot.data ?? [];

          if (dataList.isEmpty) {
            return const Center(child: Text("Data masih kosong"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final data = dataList[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    child: Icon(
                      getKategoriIcon(data.kategori),
                      color: Colors.deepOrange,
                    ),
                  ),
                  title: Text(
                    data.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.alamat),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(data.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog(
                        context: context, 
                        builder: (_) => AlertDialog(
                          title: const Text("Konfirmasi"),
                          content: const Text("Yakin Ingin Menghapus Data ini?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false), 
                              child: const Text("Batal"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true), 
                              child: const Text("Hapus"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await service.hapusData(data.id!);
                        refreshData();
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormPage(
                          tempatMakan: data,
                        ),
                      ),
                    ).then((_) => refreshData());
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FormPage(),
            ),
          ).then((_) => refreshData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}