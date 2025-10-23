# flutter_frond

# 🤖 ChatBot RAG Flutter App

Una aplicación de chat inteligente con funcionalidades avanzadas, desarrollada en Flutter con arquitectura limpia y diseño moderno.

## ✨ Características Principales

### 🎨 **Diseño Moderno**
- **Esquema de colores rojo y azul** consistente en toda la aplicación
- **Temas claro y oscuro** con cambio dinámico
- **Iconos distintivos** para usuario, bot y mensajes del sistema
- **Animaciones fluidas** y transiciones suaves
- **Diseño responsivo** que se adapta a diferentes tamaños de pantalla

### 💬 **Funcionalidades del Chat**
- **Mensajes con burbujas estilizadas** con headers informativos
- **Streaming de tokens** en tiempo real con cursor parpadeante
- **Indicadores de escritura** animados
- **Historial persistente** que se mantiene entre sesiones
- **Estadísticas del chat** con métricas detalladas

### ⚙️ **Configuración Avanzada**
- **Configuración por entornos** (desarrollo/producción)
- **Variables de entorno** configurables
- **Modo debug** con información técnica
- **Timeouts configurables** para la API
- **Límites de historial** ajustables

## 🚀 Instalación y Configuración

### Prerequisitos
- Flutter SDK (>=3.9.0)
- Dart SDK
- Android Studio / VS Code
- Emulador Android o dispositivo físico

### Instalación

1. **Instalar dependencias**
```bash
flutter pub get
```

2. **Configurar el entorno**
   - Edita `.env.dev` para desarrollo
   - Edita `.env.prod` para producción  
   - Actualiza la `API_BASE_URL` con tu servidor backend

3. **Ejecutar la aplicación**
```bash
flutter run
```

## 🎛️ Controles de la Interfaz

### AppBar
- **🤖 Logo del ChatBot** con gradiente rojo-azul
- **🌙/☀️ Botón de tema** para alternar entre claro/oscuro
- **📝 Botón de streaming** para activar/desactivar efectos de escritura
- **⋮ Menú de opciones** con herramientas avanzadas

### Menú de Opciones
- **📡 Probar conexión** - Verifica conectividad con el servidor
- **🗑️ Limpiar chat** - Borra todo el historial (con confirmación)
- **📊 Estadísticas** - Muestra métricas del chat
- **🐛 Info de debug** - Información técnica (solo en desarrollo)

## 🔧 Configuración del Backend

La aplicación se conecta a un servidor backend que debe exponer un endpoint `/chat`:

**Petición:**
```json
{
  "message": "texto del usuario",
  "history": [
    {"role": "user", "content": "mensaje anterior"},
    {"role": "assistant", "content": "respuesta anterior"}
  ]
}
```

**Respuesta:**
```json
{
  "answer": "respuesta del chatbot"
}
```

### URLs por Plataforma
- **Android Emulador**: `http://10.0.2.2:8000/`
- **Android Dispositivo**: `http://192.168.1.239:8000/`
- **iOS Simulator**: `http://localhost:8000/`
- **Web/Desktop**: `http://localhost:8000/`

## 🎨 Sistema de Temas

### Colores Principales
- **Azul Principal**: `#1565C0` (Usuario, elementos primarios)
- **Rojo Principal**: `#D32F2F` (Bot, elementos secundarios)
- **Naranja Sistema**: `#FF9800` (Mensajes del sistema)

## 📊 Funcionalidades Avanzadas

### Historial Persistente
- Guardado automático después de cada mensaje
- Carga al inicio de la aplicación
- Límite configurable de mensajes guardados

### Streaming de Tokens
- Simulación realista de escritura en tiempo real
- Cursor parpadeante durante el streaming
- Toggle on/off para activar/desactivar

### Configuración por Entornos
Variables configurables en `.env.dev` y `.env.prod`:
- `API_BASE_URL` - URL del servidor backend
- `API_TIMEOUT` - Timeout de las peticiones HTTP
- `MAX_HISTORY_MESSAGES` - Límite de mensajes en historial
- `DEBUG_MODE` - Activar/desactivar modo debug

## 🐛 Troubleshooting

### Problemas Comunes

1. **Error de conexión**
   - Verificar que el servidor backend esté ejecutándose
   - Comprobar la URL en el archivo `.env.dev`
   - Asegurar que el dispositivo esté en la misma red WiFi

2. **Aplicación no compila**
   - Ejecutar `flutter clean && flutter pub get`
   - Verificar versión de Flutter con `flutter doctor`

## 🚀 Despliegue

### Para Desarrollo
1. Configurar `.env.dev` con tu servidor local
2. Ejecutar `flutter run`

### Para Producción
1. Actualizar `.env.prod` con URLs de producción
2. Cambiar `isProduction: false` a `true` en `main.dart`
3. Compilar con `flutter build apk --release`

---

Desarrollado con ❤️ usando Flutter.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
