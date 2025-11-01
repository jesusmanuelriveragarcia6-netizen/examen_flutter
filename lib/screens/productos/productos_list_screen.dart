import 'package:flutter/material.dart';
import '../../models/producto.dart';
import '../../services/producto_service.dart';
import 'producto_form_screen.dart';

class ProductosListScreen extends StatefulWidget {
  const ProductosListScreen({super.key});

  @override
  State<ProductosListScreen> createState() => _ProductosListScreenState();
}

class _ProductosListScreenState extends State<ProductosListScreen> {
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  void cargarProductos() async {
    final data = await ProductoService.listar();
    setState(() => productos = data);
  }

  void eliminarProducto(int id) async {
    await ProductoService.eliminar(id);
    cargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final p = productos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(p.nombre[0].toUpperCase()),
              ),
              title: Text(p.nombre),
              subtitle: Text("S/.${p.precio} | Stock: ${p.stock}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => eliminarProducto(p.id),
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductoFormScreen(producto: p),
                  ),
                );
                cargarProductos();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductoFormScreen()),
          );
          cargarProductos();
        },
      ),
    );
  }
}
