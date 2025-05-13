<?php
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        $query = "SELECT NOMBRE_CATEGORIA FROM categorias_prod";
        $stmt = $pdo->query($query);
        $categorias = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($categorias);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $data = json_decode(file_get_contents('php://input'), true);
        $sql = "INSERT INTO categorias_prod (NOMBRE_CATEGORIA) VALUES (:nombre)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([':nombre' => $data['NOMBRE_CATEGORIA']]);
        echo json_encode(["success" => true]);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "error" => $e->getMessage()]);
    }
    exit;
}
?>