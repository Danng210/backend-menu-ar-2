<?php
require 'db.php';

try {
    $stmt = $pdo->query("
        SELECT ID_PEDIDO 
        FROM pedido 
        WHERE DATE(FECHA_PEDIDO) = CURDATE() 
        ORDER BY FECHA_PEDIDO ASC
    ");
    
    echo json_encode([
        'success' => true,
        'pedidos' => $stmt->fetchAll(PDO::FETCH_COLUMN),
        'cantidad' => $stmt->rowCount()
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => "Error al obtener pedidos: " . $e->getMessage()
    ]);
}
?>