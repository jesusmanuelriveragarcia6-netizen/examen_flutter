import '../config/api_config.dart';
import '../models/categoria.dart';
import 'api_service.dart';

class CategoriaService {
  static Future<List<Categoria>> listar() async {
    final data = await ApiService.getData(ApiConfig.categoriaUrl, "listar");
    return data.map<Categoria>((json) => Categoria.fromJson(json)).toList();
  }

  static Future<bool> insertar(Categoria c) async {
    return ApiService.postData(ApiConfig.categoriaUrl, "insertar", {
      "nombre": c.nombre,
      "descripcion": c.descripcion,
      "icono": c.icono,
      "color": c.color,
      "activo": c.activo ? "1" : "0"
    });
  }

  static Future<bool> actualizar(Categoria c) async {
    return ApiService.postData(ApiConfig.categoriaUrl, "actualizar", {
      "id": c.id.toString(),
      "nombre": c.nombre,
      "descripcion": c.descripcion,
      "icono": c.icono,
      "color": c.color,
      "activo": c.activo ? "1" : "0"
    });
  }

  static Future<bool> eliminar(int id) async {
    return ApiService.postData(ApiConfig.categoriaUrl, "eliminar", {"id": id.toString()});
  }
}
