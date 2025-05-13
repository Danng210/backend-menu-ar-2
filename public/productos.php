<?php
require_once 'db.php';

header('Content-Type: application/json');

try {
    if (!isset($_GET['categoria'])) {
        throw new Exception("Categoría no proporcionada");
    }

    $categoria = $_GET['categoria'];

    $sqlCategoria = "SELECT ID_CATEGORIA FROM categorias_prod WHERE NOMBRE_CATEGORIA = :categoria";
    $stmtCategoria = $pdo->prepare($sqlCategoria);
    $stmtCategoria->execute([':categoria' => $categoria]);
    $rowCategoria = $stmtCategoria->fetch(PDO::FETCH_ASSOC);

    if (!$rowCategoria) {
        echo json_encode([]);
        exit;
    }

    $idCategoria = $rowCategoria['ID_CATEGORIA'];

    $sqlProductos = "SELECT ID_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO, PRECIO, URL_IMG_PRODUCTO
                     FROM productos
                     WHERE FK_ID_CATEGORIA = :idCategoria";
    $stmtProductos = $pdo->prepare($sqlProductos);
    $stmtProductos->execute([':idCategoria' => $idCategoria]);

    $productos = $stmtProductos->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($productos);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>
