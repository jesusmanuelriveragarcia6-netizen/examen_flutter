<?php
// Activar reporte de errores para depuración
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Registrar información de depuración
$debug_info = [
    'timestamp' => date('Y-m-d H:i:s'),
    'request_method' => $_SERVER['REQUEST_METHOD'],
    'request_uri' => $_SERVER['REQUEST_URI'],
    'http_origin' => $_SERVER['HTTP_ORIGIN'] ?? 'No origin header',
    'remote_addr' => $_SERVER['REMOTE_ADDR']
];
file_put_contents('../debug_log.txt', json_encode($debug_info) . "\n", FILE_APPEND);

// Add CORS headers - asegurarse que se envían antes de cualquier salida
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Max-Age: 3600");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Origin");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once "../config/database.php";
require_once "../models/Producto.php";

$database = new Database();
$db = $database->getConnection();
$producto = new Producto($db);

// Registrar la acción solicitada
$accion = $_GET['accion'] ?? '';
file_put_contents('../debug_log.txt', "Acción solicitada en Producto: $accion\n", FILE_APPEND);

switch ($accion) {
    case 'listar':
        echo json_encode($producto->listar());
        break;

    case 'insertar':
        $ok = $producto->insertar(
            $_POST['categoria_id'],
            $_POST['nombre'],
            $_POST['descripcion'] ?? '',
            $_POST['precio'],
            $_POST['stock'],
            $_POST['codigo_barras'] ?? null,
            $_POST['imagen_url'] ?? null,
            $_POST['activo'] ?? 1
        );
        echo json_encode(["success" => $ok]);
        break;

    case 'actualizar':
        $ok = $producto->actualizar(
            $_POST['id'],
            $_POST['categoria_id'],
            $_POST['nombre'],
            $_POST['descripcion'],
            $_POST['precio'],
            $_POST['stock'],
            $_POST['codigo_barras'],
            $_POST['imagen_url'],
            $_POST['activo']
        );
        echo json_encode(["success" => $ok]);
        break;

    case 'eliminar':
        $ok = $producto->eliminar($_POST['id']);
        echo json_encode(["success" => $ok]);
        break;

    default:
        echo json_encode(["error" => "Acción no válida"]);
        break;
}
?>
