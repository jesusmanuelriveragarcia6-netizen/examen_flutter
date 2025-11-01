import 'package:flutter/material.dart';
import '../../models/categoria.dart';
import '../../services/categoria_service.dart';

class CategoriaFormScreen extends StatefulWidget {
  final Categoria? categoria;
  const CategoriaFormScreen({super.key, this.categoria});

  @override
  State<CategoriaFormScreen> createState() => _CategoriaFormScreenState();
}

class _CategoriaFormScreenState extends State<CategoriaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreCtrl, descripcionCtrl, colorCtrl, iconoCtrl;
  bool activo = true;

  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController(text: widget.categoria?.nombre ?? "");
    descripcionCtrl = TextEditingController(text: widget.categoria?.descripcion ?? "");
    iconoCtrl = TextEditingController(text: widget.categoria?.icono ?? "category");
    colorCtrl = TextEditingController(text: widget.categoria?.color ?? "#2196F3");
    activo = widget.categoria?.activo ?? true;
  }

  void guardar() async {
    if (_formKey.currentState!.validate()) {
      final cat = Categoria(
        id: widget.categoria?.id ?? 0,
        nombre: nombreCtrl.text,
        descripcion: descripcionCtrl.text,
        icono: iconoCtrl.text,
        color: colorCtrl.text,
        activo: activo,
      );

      bool ok = widget.categoria == null
          ? await CategoriaService.insertar(cat)
          : await CategoriaService.actualizar(cat);

      if (ok && mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.categoria == null ? "Nueva Categoría" : "Editar Categoría")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(controller: nombreCtrl, decoration: const InputDecoration(labelText: "Nombre")),
            TextFormField(controller: descripcionCtrl, decoration: const InputDecoration(labelText: "Descripción")),
            TextFormField(controller: iconoCtrl, decoration: const InputDecoration(labelText: "Icono")),
            TextFormField(controller: colorCtrl, decoration: const InputDecoration(labelText: "Color HEX")),
            SwitchListTile(
                title: const Text("Activo"), value: activo, onChanged: (v) => setState(() => activo = v)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: guardar, child: const Text("Guardar"))
          ]),
        ),
      ),
    );
  }
}
