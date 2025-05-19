const mongoose = require('mongoose');


const productos = new mongoose.Schema({
    nombre:{type:String, require:true},
    precio: { type: Number, required: true },
    categoria:{type:String,require: true}
});

module.exports=mongoose.model("productos", productos)