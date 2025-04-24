const express = require("express");
const app=express();
const port=3000;


// Ruta principal

app.get("/",(req, res) => {
    res.send("Hola Mundo")
});


// iniciarlizar servior

app.listen(port,()=>{
    console.log(`Servidor corriendo sobre http://localhost:${port}`)
});