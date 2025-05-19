const express = require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const cors=require('cors');
const productoRoutes=require('./routes/productoRoutes');
const clienteRoutes = require('./routes/clienteRoutes');

const app=express();
const port=3000; /*Enviar desde un punto env. (Puerto, nombre del servidor y la base de datos)*/

//Middleware

app.use(bodyParser.json());
app.use(cors());

//Conexion Mongo

mongoose.connect('mongodb://localhost:27017/tallerMongoDB_JavaScript',
    {useNewUrlParser:true,
    useUnifiedTopology:true,
})
.then(()=>console.log("MongoDB Conectado"))
.catch(err=>console.error(err));


// Ruta principal
app.use('/api/productos', productoRoutes);

app.use('/api/clientes', clienteRoutes);


// iniciarlizar servior

app.listen(port,()=>{
    console.log(`Servidor corriendo sobre http://localhost:${port}`)
});