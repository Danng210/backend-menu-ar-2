<?php
require 'db.php';

try {
    if (!isset($_GET['id_pedido'])) {
        throw new Exception("Falta ID del pedido", 400);
    }

    // Obtener detalles
    $stmtDetalle = $pdo->prepare("
        SELECT p.NOMBRE_PRODUCTO, dp.CANTIDAD, dp.SUBTOTAL
        FROM detalle_pedido dp
        JOIN productos p ON dp.FK_ID_PRODUCTO = p.ID_PRODUCTO
        WHERE dp.FK_ID_PEDIDO = :id_pedido
    ");
    $stmtDetalle->execute([':id_pedido' => $_GET['id_pedido']]);
    
    // Obtener total
    $stmtTotal = $pdo->prepare("SELECT TOTAL_PEDIDO FROM pedido WHERE ID_PEDIDO = :id_pedido");
    $stmtTotal->execute([':id_pedido' => $_GET['id_pedido']]);
    
    // Contar pedidos hoy
    $stmtHoy = $pdo->query("SELECT COUNT(*) AS cantidad FROM pedido WHERE DATE(FECHA_PEDIDO) = CURDATE()");

    echo json_encode([
        'success' => true,
        'productos' => $stmtDetalle->fetchAll(),
        'total' => $stmtTotal->fetchColumn() ?: 0,
        'numeroPedidoHoy' => $stmtHoy->fetchColumn()
    ]);

} catch (Exception $e) {
    http_response_code($e->getCode() ?: 500);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>