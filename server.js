const express = require('express');
const path = require('path');

const app = express();

// Configurar la carpeta de archivos estáticos para servir los archivos de la aplicación
app.use(express.static(path.join(__dirname, 'dist')));

// Configurar la ruta de captura (catch-all) para servir index.html
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

// Puerto en el que el servidor escuchará las solicitudes
const port = process.env.PORT || 3001;

// Iniciar el servidor
app.listen(port, () => {
  console.log(`Servidor escuchando en el puerto http://localhost:${port}`);
});
