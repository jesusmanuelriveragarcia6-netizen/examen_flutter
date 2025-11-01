<?php
class Categoria {
    private $conn;
    private $table_name = "categorias";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function listar() {
        $query = "SELECT * FROM {$this->table_name} ORDER BY id DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function insertar($nombre, $descripcion, $icono, $color, $activo) {
        $query = "INSERT INTO {$this->table_name}(nombre, descripcion, icono, color, activo)
                  VALUES (?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$nombre, $descripcion, $icono, $color, $activo]);
    }

    public function actualizar($id, $nombre, $descripcion, $icono, $color, $activo) {
        $query = "UPDATE {$this->table_name}
                  SET nombre=?, descripcion=?, icono=?, color=?, activo=?
                  WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$nombre, $descripcion, $icono, $color, $activo, $id]);
    }

    public function eliminar($id) {
        $query = "DELETE FROM {$this->table_name} WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$id]);
    }
}
?>
