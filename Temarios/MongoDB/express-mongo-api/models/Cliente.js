const mongoose = require('mongoose');


const clienteSchema = new mongoose.Schema({
    nombre:{type:String, require:true},
    edad:String,
    cedula: String
});

module.exports=mongoose.model("Cliente", clienteSchema)