class TempatMakan {
  final int? id;
  final String nama;
  final String alamat;
  final String kategori;
  final double rating;

  TempatMakan({
    this.id,
    required this.nama,
    required this.alamat,
    required this.kategori,
    required this.rating,
  });

  factory TempatMakan.fromJson(Map<String, dynamic> json) {
    return TempatMakan(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      kategori: json['kategori'],
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alamat': alamat,
      'kategori': kategori,
      'rating': rating,
    };
  }
}