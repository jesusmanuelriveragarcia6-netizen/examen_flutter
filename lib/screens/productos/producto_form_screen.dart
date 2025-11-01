import 'package:flutter/material.dart';
import '../../models/producto.dart';
import '../../services/producto_service.dart';

class ProductoFormScreen extends StatefulWidget {
  final Producto? producto;
  const ProductoFormScreen({super.key, this.producto});

  @override
  State<ProductoFormScreen> createState() => _ProductoFormScreenState();
}

class _ProductoFormScreenState extends State<ProductoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController categoriaCtrl,
      nombreCtrl,
      descripcionCtrl,
      precioCtrl,
      stockCtrl,
      codigoCtrl,
      imagenCtrl;
  bool activo = true;

  @override
  void initState() {
    super.initState();
    categoriaCtrl =
        TextEditingController(text: widget.producto?.categoriaId.toString() ?? "");
    nombreCtrl = TextEditingController(text: widget.producto?.nombre ?? "");
    descripcionCtrl = TextEditingController(text: widget.producto?.descripcion ?? "");
    precioCtrl = TextEditingController(text: widget.producto?.precio.toString() ?? "");
    stockCtrl = TextEditingController(text: widget.producto?.stock.toString() ?? "");
    codigoCtrl = TextEditingController(text: widget.producto?.codigoBarras ?? "");
    imagenCtrl = TextEditingController(text: widget.producto?.imagenUrl ?? "");
    activo = widget.producto?.activo ?? true;
  }

  void guardar() async {
    if (_formKey.currentState!.validate()) {
      final prod = Producto(
        id: widget.producto?.id ?? 0,
        categoriaId: int.parse(categoriaCtrl.text),
        nombre: nombreCtrl.text,
        descripcion: descripcionCtrl.text,
        precio: double.tryParse(precioCtrl.text) ?? 0.0,
        stock: int.tryParse(stockCtrl.text) ?? 0,
        codigoBarras: codigoCtrl.text,
        imagenUrl: imagenCtrl.text,
        activo: activo,
      );

      bool ok = widget.producto == null
          ? await ProductoService.insertar(prod)
          : await ProductoService.actualizar(prod);

      if (ok && mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.producto == null ? "Nuevo Producto" : "Editar Producto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  controller: categoriaCtrl,
                  decoration: const InputDecoration(labelText: "ID Categoría"),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null),
              TextFormField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(labelText: "Nombre"),
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null),
              TextFormField(
                  controller: descripcionCtrl,
                  decoration: const InputDecoration(labelText: "Descripción")),
              TextFormField(
                  controller: precioCtrl,
                  decoration: const InputDecoration(labelText: "Precio"),
                  keyboardType: TextInputType.number),
              TextFormField(
                  controller: stockCtrl,
                  decoration: const InputDecoration(labelText: "Stock"),
                  keyboardType: TextInputType.number),
              TextFormField(
                  controller: codigoCtrl,
                  decoration: const InputDecoration(labelText: "Código de Barras")),
              TextFormField(
                  controller: imagenCtrl,
                  decoration: const InputDecoration(labelText: "URL Imagen")),
              SwitchListTile(
                title: const Text("Activo"),
                value: activo,
                onChanged: (v) => setState(() => activo = v),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: guardar,
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
