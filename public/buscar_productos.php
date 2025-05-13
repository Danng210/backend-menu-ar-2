<?php
require 'db.php';

try {
    $nombre = $_GET['nombre'] ?? '';
    $categoria = $_GET['categoria'] ?? '';

    $sql = "SELECT p.* FROM productos p
            INNER JOIN categorias_prod c ON p.FK_ID_CATEGORIA = c.ID_CATEGORIA
            WHERE p.NOMBRE_PRODUCTO LIKE :nombre";

    $params = [':nombre' => "%$nombre%"];

    if (!empty($categoria)) {
        $sql .= " AND c.NOMBRE_CATEGORIA = :categoria";
        $params[':categoria'] = $categoria;
    }

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => "Error en la búsqueda: " . $e->getMessage()]);
}
?>