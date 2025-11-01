class Producto {
  int id;
  int categoriaId;
  String nombre;
  String descripcion;
  double precio;
  int stock;
  String codigoBarras;
  String imagenUrl;
  bool activo;

  Producto({
    required this.id,
    required this.categoriaId,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
    required this.codigoBarras,
    required this.imagenUrl,
    required this.activo,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: int.parse(json['id'].toString()),
        categoriaId: int.parse(json['categoria_id'].toString()),
        nombre: json['nombre'],
        descripcion: json['descripcion'] ?? '',
        precio: double.parse(json['precio'].toString()),
        stock: int.parse(json['stock'].toString()),
        codigoBarras: json['codigo_barras'] ?? '',
        imagenUrl: json['imagen_url'] ?? '',
        activo: json['activo'].toString() == '1',
      );
}
