<?php
require 'db.php';

try {
    $input = json_decode(file_get_contents('php://input'), true);
    $carrito = $input['carrito'] ?? [];
    
    if (empty($carrito)) {
        throw new Exception('Carrito vacío');
    }

    // Insertar pedido
    $sqlPedido = "
        INSERT INTO pedido 
        (FECHA_PEDIDO, TOTAL_PEDIDO, PREFERENCIAS_PEDIDO, METODO_PAGO) 
        VALUES (NOW(), :total, :preferencias, :metodo_pago)
    ";
    
    $stmtPedido = $pdo->prepare($sqlPedido);
    $stmtPedido->execute([
        ':total' => $input['total'],
        ':preferencias' => $input['preferencias'] ?? '',
        ':metodo_pago' => $input['metodo_pago'] ?? ''
    ]);
    
    $idPedido = $pdo->lastInsertId();

    // Insertar detalles
    foreach ($carrito as $item) {
        $stmtDetalle = $pdo->prepare("
            INSERT INTO detalle_pedido 
            (FK_ID_PRODUCTO, CANTIDAD, SUBTOTAL, FK_ID_PEDIDO)
            VALUES (:id_producto, :cantidad, :subtotal, :id_pedido)
        ");
        
        $subtotal = $item['precio'] * $item['cantidad'];
        
        $stmtDetalle->execute([
            ':id_producto' => $item['id_producto'],
            ':cantidad' => $item['cantidad'],
            ':subtotal' => $subtotal,
            ':id_pedido' => $idPedido
        ]);
    }

    echo json_encode(['success' => true, 'id_pedido' => $idPedido]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>