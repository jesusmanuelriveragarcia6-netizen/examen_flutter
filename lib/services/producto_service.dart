import '../config/api_config.dart';
import '../models/producto.dart';
import 'api_service.dart';

class ProductoService {
  static Future<List<Producto>> listar() async {
    final data = await ApiService.getData(ApiConfig.productoUrl, "listar");
    return data.map<Producto>((json) => Producto.fromJson(json)).toList();
  }

  static Future<bool> insertar(Producto p) async {
    return ApiService.postData(ApiConfig.productoUrl, "insertar", {
      "categoria_id": p.categoriaId.toString(),
      "nombre": p.nombre,
      "descripcion": p.descripcion,
      "precio": p.precio.toString(),
      "stock": p.stock.toString(),
      "codigo_barras": p.codigoBarras,
      "imagen_url": p.imagenUrl,
      "activo": p.activo ? "1" : "0"
    });
  }

  static Future<bool> actualizar(Producto p) async {
    return ApiService.postData(ApiConfig.productoUrl, "actualizar", {
      "id": p.id.toString(),
      "categoria_id": p.categoriaId.toString(),
      "nombre": p.nombre,
      "descripcion": p.descripcion,
      "precio": p.precio.toString(),
      "stock": p.stock.toString(),
      "codigo_barras": p.codigoBarras,
      "imagen_url": p.imagenUrl,
      "activo": p.activo ? "1" : "0"
    });
  }

  static Future<bool> eliminar(int id) async {
    return ApiService.postData(ApiConfig.productoUrl, "eliminar", {"id": id.toString()});
  }
}
