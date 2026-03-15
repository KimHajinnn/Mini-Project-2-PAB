import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/data_tempat_makan.dart';

class TempatMakanService {
  final supabase = Supabase.instance.client;

  Future<List<TempatMakan>> getData() async {
    final response =
        await supabase.from('tempat_makan').select().eq('user_id', supabase.auth.currentUser!.id).order('id');

    return response
        .map<TempatMakan>((json) => TempatMakan.fromJson(json))
        .toList();
  }

  Future<void> tambahData(TempatMakan data) async {
    await supabase.from('tempat_makan').insert({
      ...data.toJson(),
      'user_id' : supabase.auth.currentUser!.id,
    });
  }

  Future<void> updateData(int id, TempatMakan data) async {
    await supabase
        .from('tempat_makan')
        .update(data.toJson())
        .eq('id', id);
  }

  Future<void> hapusData(int id) async {
    await supabase
        .from('tempat_makan')
        .delete()
        .eq('id', id);
  }
}