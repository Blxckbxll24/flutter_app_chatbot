# 🚀 Guía de Ejecución - ChatBot RAG

## ⚡ Inicio Rápido

### 1. Preparar el Entorno
```bash
cd /Users/blxckbxll/Documents/Proyectos/flutter/api_flutter
flutter pub get
```

### 2. Verificar Configuración
Asegúrate de que tu archivo `.env.dev` tenga la configuración correcta:
```bash
cat .env.dev
```

Deberías ver algo similar a:
```
API_BASE_URL=http://192.168.1.239:8000/
ENVIRONMENT=development
DEBUG_MODE=true
API_TIMEOUT=30000
MAX_HISTORY_MESSAGES=100
ENABLE_LOGGING=true
```

### 3. Verificar Servidor Backend
Antes de ejecutar la app, verifica que tu servidor esté funcionando:
```bash
curl -X POST http://192.168.1.239:8000/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "test", "history": []}'
```

### 4. Ejecutar la Aplicación
```bash
flutter run
```

## 🎯 Funcionalidades Implementadas

### ✅ Funcionalidades Básicas
- [x] Chat con interfaz moderna
- [x] Conexión al backend RAG
- [x] Burbujas de mensajes estilizadas
- [x] Indicadores de carga

### ✅ Funcionalidades Bonus
- [x] **Historial Persistente** - Los mensajes se guardan automáticamente
- [x] **Temas Claro/Oscuro** - Botón en AppBar para cambiar tema
- [x] **Streaming de Tokens** - Efecto de escritura en tiempo real
- [x] **Configuración por Entornos** - Variables .env para dev/prod

### ✅ Funcionalidades Extra
- [x] **Estadísticas del Chat** - Métricas detalladas
- [x] **Menú de Opciones** - Herramientas avanzadas
- [x] **Info de Debug** - Panel técnico para desarrollo
- [x] **Exportar/Importar** - Funciones de respaldo

## 🎨 Controles de la Interfaz

### AppBar Superior
| Botón | Función | Descripción |
|-------|---------|-------------|
| 🌙/☀️ | Tema | Alterna entre modo claro y oscuro |
| 📝 | Streaming | Activa/desactiva efecto de escritura |
| ⋮ | Menú | Abre opciones avanzadas |

### Menú Desplegable
| Opción | Función | Descripción |
|--------|---------|-------------|
| 📡 Probar conexión | Test | Verifica conectividad con servidor |
| 🗑️ Limpiar chat | Clear | Borra historial (con confirmación) |
| 📊 Estadísticas | Stats | Muestra métricas del chat |
| 🐛 Info debug | Debug | Información técnica (solo dev) |

## 🔧 Configuración de Red

### Para Emulador Android
```bash
# El emulador usa una IP especial
API_BASE_URL=http://10.0.2.2:8000/
```

### Para Dispositivo Android Real
```bash
# Usa la IP local de tu computadora
API_BASE_URL=http://192.168.1.239:8000/
```

### Para iOS/Web/Desktop
```bash
# Usa localhost
API_BASE_URL=http://localhost:8000/
```

## 📱 Pruebas de Funcionalidad

### 1. Probar Chat Básico
1. Abrir la aplicación
2. Escribir "Hola" en el campo de texto
3. Tocar el botón de enviar
4. Verificar que aparece la respuesta del bot

### 2. Probar Streaming
1. Tocar el botón de streaming (📝) en la AppBar
2. Enviar un mensaje
3. Observar el efecto de escritura con cursor parpadeante

### 3. Probar Cambio de Tema
1. Tocar el botón de tema (🌙/☀️) en la AppBar
2. Verificar que cambia entre claro y oscuro
3. Reiniciar app y verificar que se mantiene el tema

### 4. Probar Historial Persistente
1. Enviar varios mensajes
2. Cerrar y reabrir la aplicación
3. Verificar que los mensajes siguen ahí

### 5. Probar Estadísticas
1. Tocar el menú (⋮) en la AppBar
2. Seleccionar "Estadísticas"
3. Verificar métricas del chat

## 🐛 Solución de Problemas

### Error: "No se puede conectar al servidor"
```bash
# 1. Verificar que el servidor esté ejecutándose
curl http://192.168.1.239:8000/

# 2. Verificar configuración de red
ping 192.168.1.239

# 3. Usar botón "Probar conexión" en la app
```

### Error: "Gradle build failed"
```bash
# Limpiar y reconstruir
flutter clean
flutter pub get
flutter run
```

### Error: "No aparecen los mensajes"
```bash
# Verificar permisos de almacenamiento
# Limpiar datos de la app desde Configuración > Apps
```

## 📊 Métricas de Rendimiento

### Tiempo de Respuesta Esperado
- **Conexión local**: < 100ms
- **Streaming simulado**: 50ms por palabra
- **Carga de historial**: < 500ms

### Uso de Memoria
- **App básica**: ~30MB
- **Con historial**: ~35MB
- **Streaming activo**: ~40MB

## 🎮 Modo Debug

En modo desarrollo, la aplicación muestra información adicional:

### Console Logs
```
🚀 Aplicación iniciada
🌍 Entorno: development
🔗 API URL: http://192.168.1.239:8000/
🎨 Tema inicial: ThemeMode.system
```

### Panel de Debug
Accesible desde el menú ⋮ → "Info de debug":
- Entorno actual
- URL de la API
- Configuraciones activas
- Timeouts y límites

## 🚀 Próximos Pasos

### Para Producción
1. Actualizar `.env.prod` con URL real
2. Cambiar `isProduction: true` en `main.dart`
3. Compilar release: `flutter build apk --release`

### Para Desarrollo Continuo
1. Agregar más tests unitarios
2. Implementar streaming real con WebSockets
3. Añadir más opciones de personalización
4. Integrar analytics y crashlytics

---

¡Tu ChatBot está listo para usar! 🎉
