<?php
require 'db.php';

try {
    $data = json_decode(file_get_contents('php://input'), true);
    
    // Validación
    if (empty($data['carrito'])) {
        throw new Exception("El carrito está vacío", 400);
    }
    if (empty($data['metodo_pago'])) {
        throw new Exception("Método de pago no especificado", 400);
    }

    $pdo->beginTransaction();

    // Insertar pedido
    $stmtPedido = $pdo->prepare("
        INSERT INTO pedido 
        (ID_PEDIDO, TOTAL_PEDIDO, FECHA_PEDIDO, PREFERENCIAS_PEDIDO, METODO_PAGO)
        VALUES (:id, :total, NOW(), :preferencias, :metodo_pago)
    ");
    
    $idPedido = 'ped-' . time();
    $stmtPedido->execute([
        ':id' => $idPedido,
        ':total' => $data['total'],
        ':preferencias' => $data['preferencias'] ?? '',
        ':metodo_pago' => $data['metodo_pago']
    ]);

    // Insertar detalles
    $stmtDetalle = $pdo->prepare("
        INSERT INTO detalle_pedido 
        (FK_ID_PEDIDO, FK_ID_PRODUCTO, CANTIDAD, SUBTOTAL)
        VALUES (:id_pedido, :id_producto, :cantidad, :subtotal)
    ");

    foreach ($data['carrito'] as $item) {
        $stmtDetalle->execute([
            ':id_pedido' => $idPedido,
            ':id_producto' => $item['id'],
            ':cantidad' => $item['cantidad'],
            ':subtotal' => $item['subtotal']
        ]);
    }

    $pdo->commit();
    echo json_encode(['success' => true, 'id_pedido' => $idPedido]);

} catch (Exception $e) {
    $pdo->rollBack();
    http_response_code($e->getCode() ?: 500);
    echo json_encode([
        'success' => false,
        'message' => "Error al procesar pedido: " . $e->getMessage()
    ]);
}
?>