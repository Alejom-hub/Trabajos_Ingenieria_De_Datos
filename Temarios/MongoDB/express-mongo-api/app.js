const express = require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const mcors=require('cors');
const itemRoutes=require('./routes/productoRoutes')

const app=express();
const port=3000; /*Enviar desde un punto env. (Puerto, nombre del servidor y la base de datos)*/

//Middleware

app.use(bodyParser.json());
app.use(cors());

//Conexion Mongo

mongoose.connect('mongodb://localhost:27017/miapp',{
    useNewIrlParser:true,
    useUnifiedTipologt:true,
})

.then(()=>console.log("MongoDB Conectado"))
.catch(err=>console.err(err))

// Ruta principal
app.use ("api/items",itemRoutes);


// iniciarlizar servior

app.listen(port,()=>{
    console.log(`Servidor corriendo sobre http://localhost:${port}`)
});