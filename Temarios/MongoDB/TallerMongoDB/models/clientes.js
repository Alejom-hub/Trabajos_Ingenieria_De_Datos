const mongoose = require('mongoose');


const clienteTaller = new mongoose.Schema({
    nombre:{type:String, require:true},
    edad: { type: Number, require: true },
    correo: {type:String, require:true},
    activo : {type: Boolean, require:true},
    creadoEn:{type:Date,default:Date.now}
});

module.exports=mongoose.model("Cliente", clienteTaller)