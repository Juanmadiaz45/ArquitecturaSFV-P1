#!/bin/bash

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Docker no está instalado. Por favor, instala Docker primero."
    exit 1
fi

# Detener y eliminar el contenedor si ya existe
if docker ps -a --filter "name=devops-app" | grep -q devops-app; then
    echo "Deteniendo y eliminando el contenedor existente..."
    docker stop devops-app > /dev/null
    docker rm devops-app > /dev/null
fi

# Construir la imagen de Docker
echo "Construyendo la imagen de Docker..."
docker build -t devops-evaluation-app .

# Verificar si la construcción fue exitosa
if [ $? -ne 0 ]; then
    echo "Error al construir la imagen de Docker."
    exit 1
fi

# Ejecutar el contenedor
echo "Ejecutando el contenedor..."
docker run -d -p 8080:8080 --name devops-app -e PORT=8080 -e NODE_ENV=production devops-evaluation-app

# Verificar si el contenedor está en ejecución
if [ $? -ne 0 ]; then
    echo "Error al ejecutar el contenedor."
    exit 1
fi

echo "Esperando que la aplicación se inicie..."
sleep 5

# Prueba básica
echo "Realizando prueba básica..."
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health)

if [ "$response" == "200" ]; then
    echo "La aplicación está funcionando correctamente."
else
    echo "Error: La aplicación no responde correctamente. Código de estado: $response"
    exit 1
fi

echo "Despliegue exitoso."