from flask import Flask, render_template, request, redirect, url_for, session, flash
import requests
from functools import wraps

app = Flask(__name__)
app.secret_key = 'clave_secreta_segura'  # Requerido para sesiones

# Decorador para requerir autenticación en las rutas
# Este decorador verifica si el usuario ha iniciado sesión antes de permitir el acceso a ciertas rutas
# Si no ha iniciado sesión, redirige al usuario a la página de login con un mensaje de advertencia
# Se utiliza el decorador `@wraps` para preservar la información
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not session.get('logged_in'):
            flash('Debes iniciar sesión para acceder a esta página.', 'warning')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

# URL base del backend en Spring Boot
SPRING_BOOT_URL = "http://localhost:8080/api"

### ---------- LOGIN ----------

@app.route('/', methods=['GET', 'POST'])
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        usuario = request.form.get('usuario')
        contrasena = request.form.get('contrasena')

        try:
            response = requests.post(f"{SPRING_BOOT_URL}/usuarios/login", 
                json={"usuario": usuario, "contrasena": contrasena},
                headers={"Content-Type": "application/json"}
            )

            if response.status_code == 200:
                user_data = response.json()
                session['user_id'] = user_data.get('usuario')
                session['logged_in'] = True
                flash('Login exitoso', 'success')
                return redirect(url_for('bienvenida'))
            else:
                try:
                    error_data = response.json()
                    mensaje = error_data.get('error', 'Credenciales incorrectas')
                except ValueError:
                    mensaje = 'Error en la respuesta del servidor (no es JSON)'
                flash(f"Error: {mensaje}", 'error')

        except requests.exceptions.RequestException as e:
            flash(f"Error de conexión con el servidor: {str(e)}", 'error')

    return render_template('index.html')

@app.route('/logout')
def logout():
    session.clear()
    flash('Has cerrado sesión exitosamente', 'info')
    return redirect(url_for('login'))


### ---------- REGISTRO DE USUARIO ----------
@app.route("/registrar-usuario", methods=["GET", "POST"])
def registrar_usuario():
    if request.method == "POST":
        nombre = request.form['nombre']
        usuario = request.form['usuario']
        correo = request.form['correo']
        contrasena = request.form['contrasena']

        try:
            response = requests.post(f"{SPRING_BOOT_URL}/usuarios/registrar", 
                json={
                    "nombre": nombre,
                    "usuario": usuario,
                    "correo": correo,
                    "contrasena": contrasena
                },
                headers={"Content-Type": "application/json"}
            )

            if response.status_code == 201:
                flash('Usuario registrado exitosamente', 'success')
                return redirect(url_for('login'))
            else:
                try:
                    error_data = response.json()
                    mensaje_error = error_data.get('mensaje', 'Error desconocido')
                except:
                    mensaje_error = 'Error desconocido al registrar usuario'
                flash(f"Error: {mensaje_error}", 'error')

        except requests.exceptions.RequestException as e:
            flash(f'Error de conexión con el servidor: {str(e)}', 'error')

    return render_template("Registrar.html")


### ---------- BIENVENIDA ----------
@app.route('/bienvenida')
@login_required
def bienvenida():
    if not session.get('logged_in'):
        flash('Por favor, inicia sesión primero.', 'warning')
        return redirect(url_for('login'))
    
    return render_template("bienvenida.html", usuario=session.get('user_id'))


### ---------- PRODUCTOS ----------
@app.route('/productos', methods=['GET'])
@login_required
def listar_productos():
    try:
        response = requests.get(f"{SPRING_BOOT_URL}/productos")
        productos = response.json()
    except Exception as e:
        productos = []
        print("Error al conectar con el backend:", e)
    return render_template("productos.html", productos=productos)

@app.route('/nuevo-producto', methods=['GET', 'POST'])
@login_required
def nuevo_producto():
    if request.method == 'POST':
        data = {
            "nombre_producto": request.form['nombre'],
            "precio_venta": int(request.form['precio']),
            "costo": int(request.form['costo']),
            "stock": int(request.form['stock'])
        }
        requests.post(f"{SPRING_BOOT_URL}/productos", json=data)
        return redirect(url_for('bienvenida'))
    return render_template('nuevo-producto.html')


### ---------- VENTAS ----------
@app.route('/nueva-venta', methods=['GET', 'POST'])
@login_required
def nueva_venta():
    if request.method == 'POST':
        try:
            producto_id = request.form['producto_id']
            cantidad = int(request.form['cantidad'])
            medio_pago_id = request.form['medio_pago_id']
            precio_unitario = float(request.form['precio_unitario'])

            data = {
                "producto": {"id": producto_id},
                "cantidad": cantidad,
                "precioUnitario": precio_unitario,
                "medioPago": {"id": medio_pago_id}
            }

            response = requests.post(f"{SPRING_BOOT_URL}/ventas", json=data)

            if response.status_code == 201:
                return redirect(url_for('bienvenida'))
            else:
                return f"Error al registrar la venta: {response.text}", 500
        except Exception as e:
            return f"Error en el servidor Flask: {e}", 500

    productos = requests.get(f"{SPRING_BOOT_URL}/productos").json()
    medios_pago = requests.get(f"{SPRING_BOOT_URL}/MedioPago").json()
    return render_template("nueva-venta.html", productos=productos, medios_pago=medios_pago)


### ---------- CIERRE DE CAJA ----------
@app.route('/cierre-caja')
@login_required
def cierre_caja():
    try:
        response = requests.get(f"{SPRING_BOOT_URL}/ventas/hoy")
        ventas = response.json()
        total = sum(venta["cantidad"] * venta["precioUnitario"] for venta in ventas)
    except Exception as e:
        ventas = []
        total = 0
        print("Error al obtener ventas del día:", e)

    return render_template("cierre-caja.html", ventas=ventas, total=total)


### ---------- MAIN ----------
if __name__ == '__main__':
    app.run(debug=True)

# flask-frontend/app.py
# Este es el archivo principal de la aplicación Flask que sirve como frontend para interactuar con el
# backend de Spring Boot. Proporciona rutas para login, registro de usuario, listado de productos,
# Para ejecutar la aplicación, asegúrate de que el backend esté corriendo en el puerto 8080.
# Puedes iniciar el servidor Flask con el comando: flask run
# `flask run` y acceder a la aplicación en http://localhost:5000.