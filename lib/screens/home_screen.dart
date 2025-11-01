import 'package:flutter/material.dart';
import 'categorias/categorias_list_screen.dart';
import 'productos/productos_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Manager")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: const Text("Categorías"),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const CategoriasListScreen())),
          ),
          ElevatedButton(
            child: const Text("Productos"),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ProductosListScreen())),
          ),
        ]),
      ),
    );
  }
}
