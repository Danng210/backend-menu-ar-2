<?php
require 'db.php';

header('Content-Type: application/json');

$request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$endpoints = [
    '/categorias' => 'Gestión de categorías (GET/POST)',
    '/productos' => 'Obtener productos por categoría',
    '/realizar_pedido' => 'Procesar nuevo pedido (POST)',
    '/detallepedido' => 'Detalle de pedidos (POST)',
    // Añade todos tus endpoints aquí
];

if ($_SERVER['REQUEST_METHOD'] === 'GET' && $request_uri === '/') {
    echo json_encode([
        'status' => 'API en funcionamiento',
        'endpoints' => $endpoints,
        'documentacion' => 'Agrega aquí tu enlace a documentación si tienes'
    ]);
    exit;
}

// Manejo de rutas no existentes
http_response_code(404);
echo json_encode([
    'error' => 'Endpoint no encontrado',
    'available_endpoints' => array_keys($endpoints)
]);
?>