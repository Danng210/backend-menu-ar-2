<?php
require 'db.php';

try {
    if (!isset($_GET['id'])) {
        throw new Exception("Se requiere ID de pedido", 400);
    }

    $sql = "
        SELECT 
            p.ID_PEDIDO,
            p.FECHA_PEDIDO,
            p.TOTAL_PEDIDO,
            pr.ID_PRODUCTO,
            pr.NOMBRE_PRODUCTO,
            pr.PRECIO,
            dp.CANTIDAD,
            dp.SUBTOTAL
        FROM pedido p
        JOIN detalle_pedido dp ON p.ID_PEDIDO = dp.FK_ID_PEDIDO
        JOIN productos pr ON dp.FK_ID_PRODUCTO = pr.ID_PRODUCTO
        WHERE p.ID_PEDIDO = :id_pedido
        ORDER BY pr.NOMBRE_PRODUCTO
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([':id_pedido' => $_GET['id']]);
    $results = $stmt->fetchAll();

    if (empty($results)) {
        throw new Exception("Pedido no encontrado", 404);
    }

    $response = [
        "pedido" => [
            "id" => $results[0]['ID_PEDIDO'],
            "fecha" => $results[0]['FECHA_PEDIDO'],
            "total" => $results[0]['TOTAL_PEDIDO']
        ],
        "productos" => array_map(function($row) {
            return [
                "id" => $row['ID_PRODUCTO'],
                "nombre" => $row['NOMBRE_PRODUCTO'],
                "precio" => $row['PRECIO'],
                "cantidad" => $row['CANTIDAD'],
                "subtotal" => $row['SUBTOTAL']
            ];
        }, $results)
    ];

    echo json_encode($response);

} catch (Exception $e) {
    http_response_code($e->getCode() ?: 500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>