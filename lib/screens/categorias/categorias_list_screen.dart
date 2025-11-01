import 'package:flutter/material.dart';
import '../../models/categoria.dart';
import '../../services/categoria_service.dart';
import 'categoria_form_screen.dart';

class CategoriasListScreen extends StatefulWidget {
  const CategoriasListScreen({super.key});

  @override
  State<CategoriasListScreen> createState() => _CategoriasListScreenState();
}

class _CategoriasListScreenState extends State<CategoriasListScreen> {
  List<Categoria> categorias = [];

  @override
  void initState() {
    super.initState();
    cargarCategorias();
  }

  void cargarCategorias() async {
    final data = await CategoriaService.listar();
    setState(() => categorias = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categorías")),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, i) {
          final c = categorias[i];
          return ListTile(
            title: Text(c.nombre),
            subtitle: Text(c.descripcion),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await CategoriaService.eliminar(c.id);
                cargarCategorias();
              },
            ),
            onTap: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CategoriaFormScreen(categoria: c)));
              cargarCategorias();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const CategoriaFormScreen()));
          cargarCategorias();
        },
      ),
    );
  }
}
