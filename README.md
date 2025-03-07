# ArquitecturaSFV-P1

# Evaluación Práctica - Ingeniería de Software V

## Información del Estudiante
- **Nombre: Juan Manuel Díaz Moreno**
- **Código: A00394477**
- **Fecha: 07/03/2025**

## Resumen de la Solución
Esta implementación consiste en la contenerización de una aplicación Node.js simple utilizando Docker, junto con un script de automatización para facilitar su despliegue. La idea fue realizar la solución siguiendo principios DevOps fundamentales como automatización, integración continua y consistencia de entornos. La aplicación se ejecuta en un contenedor Docker optimizado, con variables de entorno configurables y verificaciones integradas.

## Dockerfile
El Dockerfile fue diseñado siguiendo buenas prácticas para garantizar un entorno de ejecución eficiente y seguro. Para esto tomé las siguiente decisiones:

1. Imagen base (node:18-alpine):  
   Se utiliza una imagen oficial de Node.js basada en Alpine Linux, que es ligera y optimizada para entornos de producción.

2. Directorio de trabajo (WORKDIR /app):  
   Se establece un directorio de trabajo dentro del contenedor para organizar los archivos de la aplicación.

3. Copia de dependencias (COPY package*.json ./):  
   Se copian los archivos package.json y package-lock.json para instalar las dependencias necesarias.

4. Instalación de dependencias (RUN npm install --production):  
   Se instalan solo las dependencias necesarias para producción, lo que reduce el tamaño de la imagen final.

5. Copia del código fuente (COPY app.js ./):  
   Se copia el archivo principal de la aplicación (app.js) al directorio de trabajo.

6. Exposición del puerto (EXPOSE 8080):  
   Se documenta que la aplicación escuchará en el puerto 8080.

7. Variables de entorno (ENV):  
   Se definen variables de entorno por defecto para el entorno de producción y el puerto.

8. Comando de inicio (CMD ["node", "app.js"]):  
   Se especifica el comando que se ejecutará al iniciar el contenedor.

## Script de Automatización
1. Verificación de Docker:  
   El script verifica si Docker está instalado en el sistema. Si no lo está, muestra un mensaje de error y se detiene.

2. Gestión de contenedores existentes:  
   Si ya existe un contenedor con el nombre `devops-app`, el script lo detiene y lo elimina para evitar conflictos.

3. Construcción de la imagen:  
   Construye la imagen de Docker a partir del Dockerfile. Si la construcción falla, el script se detiene y muestra un mensaje de error.

4. Ejecución del contenedor:  
   Ejecuta un nuevo contenedor con las variables de entorno adecuadas. Si la ejecución falla, el script se detiene y muestra un mensaje de error.

5. Espera para la inicialización:  
   Espera 5 segundos para dar tiempo a que la aplicación se inicie correctamente.

6. Prueba básica:  
   Realiza una prueba básica utilizando `curl` para verificar que el endpoint de salud (`/health`) responde con el código `200`. Si la prueba falla, el script se detiene y muestra un mensaje de error.

7. Resumen del despliegue:  
   Si todo funciona correctamente, el script muestra un mensaje de éxito.

## Principios DevOps Aplicados
1. **Automatización**  
   El script de automatización elimina tareas manuales, reduciendo errores humanos y garantizando procesos reproducibles.

2. **Infraestructura como Código (IaC)**  
   El Dockerfile y el script de automatización representan la infraestructura como código, permitiendo versionar, reproducir y compartir la configuración de manera consistente.

3. **Integración Continua**  
   El script sienta las bases para la integración continua al proporcionar un método estandarizado para construir, desplegar y probar la aplicación.

4. **Monitoreo y Feedback**  
   La aplicación incluye un endpoint de health (`/health`) y el script verifica activamente el funcionamiento del servicio, proporcionando feedback inmediato.

## Captura de Pantalla
[Incluye al menos una captura de pantalla que muestre tu aplicación funcionando en el contenedor]

## Mejoras Futuras
1. **Implementación de orquestación con Docker Compose**  
   - Permitiría gestionar múltiples contenedores y servicios relacionados.  
   - Facilitaría la configuración de redes, volúmenes y escalado.

2. **Pipeline de CI/CD completo**  
   - Integración con sistemas como GitHub Actions o Jenkins.  
   - Ejecución automática de pruebas unitarias e integración.   

3. **Monitoreo y logging avanzados**  
   - Integración con herramientas como Prometheus, Grafana o ELK Stack.  
   - Configuración de alertas para métricas críticas.


## Instrucciones para Ejecutar
1. Clona el repositorio.
2. Navega al directorio del proyecto.
3. Ejecuta el script de automatización:
   ```bash
   ./deploy.sh