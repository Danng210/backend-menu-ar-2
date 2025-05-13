<?php
require 'db.php';

try {
    if (!isset($_GET['id'])) {
        throw new Exception("ID no proporcionado", 400);
    }

    $stmt = $pdo->prepare("SELECT NOMBRE_PRODUCTO FROM productos WHERE ID_PRODUCTO = :id LIMIT 1");
    $stmt->execute([':id' => $_GET['id']]);
    $result = $stmt->fetch();

    if ($result) {
        echo json_encode($result);
    } else {
        http_response_code(404);
        echo json_encode(["error" => "Producto no encontrado"]);
    }

} catch (Exception $e) {
    http_response_code($e->getCode() ?: 500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>