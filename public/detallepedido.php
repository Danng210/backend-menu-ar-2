<?php
require 'db.php';

try {
    $data = json_decode(file_get_contents('php://input'), true);

    if (!isset($data['id_producto']) || !isset($data['cantidad'])) {
        throw new Exception("Datos incompletos");
    }

    // Obtener precio
    $stmt = $pdo->prepare("SELECT PRECIO FROM productos WHERE ID_PRODUCTO = :id");
    $stmt->execute([':id' => $data['id_producto']]);
    $producto = $stmt->fetch();

    if (!$producto) {
        throw new Exception("Producto no encontrado");
    }

    // Insertar detalle
    $stmt = $pdo->prepare("
        INSERT INTO detalle_pedido 
        (FK_ID_PRODUCTO, CANTIDAD, SUBTOTAL, FK_ID_PEDIDO) 
        VALUES (:id_producto, :cantidad, :subtotal, 'pendiente')
    ");

    $subtotal = $producto['PRECIO'] * $data['cantidad'];
    
    $stmt->execute([
        ':id_producto' => $data['id_producto'],
        ':cantidad' => $data['cantidad'],
        ':subtotal' => $subtotal
    ]);

    echo json_encode(["success" => true]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}
?>