const express = require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const mcors=require('cors');
const itemRoutes=require('./routes/productoRoutes');
const clienteRoutes = require('./routes/clienteRoutes');

const app=express();
const port=3000; /*Enviar desde un punto env. (Puerto, nombre del servidor y la base de datos)*/

//Middleware

app.use(bodyParser.json());
app.use(mcors());

//Conexion Mongo

mongoose.connect('mongodb://localhost:27017/miapp',
    {useNewUrlParser:true,
    useUnifiedTopology:true,
})
.then(()=>console.log("MongoDB Conectado"))
.catch(err=>console.error(err));

// Ruta principal
app.use('/api/items', itemRoutes);

app.use('/api/clientes', clienteRoutes);


// iniciarlizar servior

app.listen(port,()=>{
    console.log(`Servidor corriendo sobre http://localhost:${port}`)
});