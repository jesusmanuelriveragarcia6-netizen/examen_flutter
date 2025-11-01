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
require_once "../models/Categoria.php";

$database = new Database();
$db = $database->getConnection();
$categoria = new Categoria($db);

$accion = $_GET['accion'] ?? '';
// Registrar la acción solicitada
file_put_contents('../debug_log.txt', "Acción solicitada: $accion\n", FILE_APPEND);

switch ($accion) {
    case 'listar':
        echo json_encode($categoria->listar());
        break;

    case 'insertar':
        $ok = $categoria->insertar(
            $_POST['nombre'],
            $_POST['descripcion'] ?? '',
            $_POST['icono'] ?? 'category',
            $_POST['color'] ?? '#2196F3',
            $_POST['activo'] ?? 1
        );
        echo json_encode(["success" => $ok]);
        break;

    case 'actualizar':
        $ok = $categoria->actualizar(
            $_POST['id'],
            $_POST['nombre'],
            $_POST['descripcion'],
            $_POST['icono'],
            $_POST['color'],
            $_POST['activo']
        );
        echo json_encode(["success" => $ok]);
        break;

    case 'eliminar':
        $ok = $categoria->eliminar($_POST['id']);
        echo json_encode(["success" => $ok]);
        break;

    default:
        echo json_encode(["error" => "Acción no válida"]);
        break;
}
?>
