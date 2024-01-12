import 'package:dio/dio.dart';
import 'package:hivepractice/db/model/namesmodel.dart';

class NameService {
  final url = "https://65a0f682600f49256fb097a5.mockapi.io/Usernames";
  Dio dio = Dio();
  Future<List<NamesModel>> fetchNames() async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List datas = response.data;
        List<NamesModel> names =
            datas.map((names) => NamesModel.fromJson(names)).toList();
        return names;
      } else {
        throw Exception('fetch error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  postName(NamesModel data) async {
    try {
      await dio.post(url, data: data.toJson());
    } catch (e) {
      throw Exception();
    }
  }

  deleteName(String id) async {
    final deleteurl = "$url/$id";
    try {
      await dio.delete(deleteurl);
    } catch (e) {}
  }
}
