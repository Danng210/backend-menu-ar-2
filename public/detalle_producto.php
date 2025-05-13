<?php
require 'db.php';

try {
    if (!isset($_GET['nombre'])) {
        throw new Exception("Nombre de producto no proporcionado", 400);
    }

    $stmt = $pdo->prepare("
        SELECT ID_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO, PRECIO
        FROM productos
        WHERE NOMBRE_PRODUCTO = :nombre
        LIMIT 1
    ");
    
    $stmt->execute([':nombre' => $_GET['nombre']]);
    $producto = $stmt->fetch();

    echo $producto ? json_encode($producto) : json_encode(null);

} catch (Exception $e) {
    http_response_code($e->getCode() ?: 500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>