<?php
class Producto {
    private $conn;
    private $table_name = "productos";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function listar() {
        $query = "SELECT p.*, c.nombre AS categoria
                  FROM {$this->table_name} p
                  INNER JOIN categorias c ON p.categoria_id = c.id
                  ORDER BY p.id DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function insertar($categoria_id, $nombre, $descripcion, $precio, $stock, $codigo_barras, $imagen_url, $activo) {
        $query = "INSERT INTO {$this->table_name}
            (categoria_id, nombre, descripcion, precio, stock, codigo_barras, imagen_url, activo)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$categoria_id, $nombre, $descripcion, $precio, $stock, $codigo_barras, $imagen_url, $activo]);
    }

    public function actualizar($id, $categoria_id, $nombre, $descripcion, $precio, $stock, $codigo_barras, $imagen_url, $activo) {
        $query = "UPDATE {$this->table_name}
                  SET categoria_id=?, nombre=?, descripcion=?, precio=?, stock=?, codigo_barras=?, imagen_url=?, activo=?
                  WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$categoria_id, $nombre, $descripcion, $precio, $stock, $codigo_barras, $imagen_url, $activo, $id]);
    }

    public function eliminar($id) {
        $query = "DELETE FROM {$this->table_name} WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$id]);
    }
}
?>
