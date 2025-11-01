class Categoria {
  int id;
  String nombre;
  String descripcion;
  String icono;
  String color;
  bool activo;

  Categoria({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.icono,
    required this.color,
    required this.activo,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: int.parse(json['id'].toString()),
        nombre: json['nombre'],
        descripcion: json['descripcion'] ?? '',
        icono: json['icono'] ?? 'category',
        color: json['color'] ?? '#2196F3',
        activo: json['activo'].toString() == '1',
      );
}
