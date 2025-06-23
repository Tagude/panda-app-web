# 🐼 Panda App Web

Aplicación web para registrar productos, ventas y cierre de caja, desarrollada con **Flask (frontend)** y **Spring Boot (backend)**. Pensada para facilitar la gestión de pequeños negocios de forma simple y eficiente.

---

## ⚙️ Tecnologías utilizadas

- **Frontend:** Flask (Python)
- **Backend:** Spring Boot (Java)
- **Base de datos:** MySQL
- **HTML5 / CSS3 / JS**
- **Bootstrap y estilos personalizados**
- **API RESTful**
- **Control de acceso por sesión**

---

## 🧩 Estructura del proyecto

Mi proyecto Panda/
│
├── flask-frontend/ # Frontend en Flask
│ ├── app.py # Lógica principal
│ ├── templates/ # Archivos HTML (Jinja2)
│ ├── static/ # Archivos estáticos (CSS, imágenes)
│ └── requirements.txt # Dependencias de Flask
│
├── pandaapp/ # Backend en Spring Boot
│ ├── src/main/java/ # Código Java (controladores, modelos, repos, servicios)
│ ├── src/main/resources/ # Configuración, plantillas de prueba
│ └── pom.xml # Configuración de Maven
│
└── README.md # Este archivo


---

## 🚀 ¿Cómo ejecutar el proyecto?

### 🧪 Requisitos previos

- Python 3.10+ y `pip`
- Java 17 o superior
- Maven
- MySQL corriendo en `localhost` (puerto 3306)

---

### Clona el repositorio

```bash
git clone https://github.com/Tagude/panda-app-web.git
cd panda-app-web

---------
## ☕ Ejecutar el backend (Spring Boot)

cd pandaapp
./mvnw spring-boot:run

La API se expone por defecto en:
👉 http://localhost:8080/api

## 🐍 Ejecutar el frontend (Flask)

cd flask-frontend
python3 -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
pip install -r requirements.txt
python app.py

Abre en tu navegador:
👉 http://localhost:5000

✅ Funcionalidades actuales
Registro e inicio de sesión con validación
Registro y listado de productos
Registro de ventas con descuento automático de stock
Cierre de caja: listado de ventas del día y total acumulado
Control de rutas protegidas para usuarios autenticados
Sistema de mensajes (flash) para retroalimentación

🛡️ Seguridad
Las rutas sensibles están protegidas mediante sesiones.
El backend maneja validaciones y excepciones.
A futuro se puede agregar JWT o autenticación por roles.

💡 Próximas mejoras
Permitir múltiples productos en una sola venta
Historial de ventas detallado
Reportes exportables
Estilos responsive (versión móvil)
Dockerización del proyecto

📄 Licencia
Este proyecto es de uso libre para fines educativos y de práctica profesional.
Desarrollado por @Tagude 💻💫
