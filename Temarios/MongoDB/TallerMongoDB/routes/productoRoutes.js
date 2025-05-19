const express=require("express")
const router=express.Router();
const Producto= require("../models/productos")

//Registrar un producto
router.post("/", async(req,res)=>{
    
try{
const producto = new Producto(req.body);
await producto.save();

    res.status(201).json(producto);


}catch(error){
    res.status(400).json({error:error.message})
}
});

//Consultar todos los productos
router.get("/", async(req,res)=>{

try{
    const producto = await Producto.find();
    res.json(producto);


}catch(error){
    res.status(500).json({error:error.message})
}

});

//Consultar producto por id
router.get("/:id", async(req,res)=>{

try{
    const producto = await Producto.findById(req.params.id);
    if (!producto ) return res.status(404).json({error : "Producto No Encontrado"})
    res.json(producto);


}catch(error){
    res.status(500).json({error:error.message})
}

});

//modificar datos del producto

router.put("/:id", async(req,res)=>{

try{
    const producto = await Producto.findByIdAndUpdate(req.params.id, req.body, {new:true});
    if (!producto ) return res.status(404).json({error : "Producto No Encontrado"})
    res.json(producto);


}catch(error){
    res.status(500).json({error:error.message})
}

});

//eliminar un producto
router.delete("/:id", async(req,res)=>{

try{
    const producto = await Producto.findByIdAndDelete(req.params.id);
    if (!producto ) return res.status(404).json({error : "Producto No Encontrado"})
    res.json(producto);


}catch(error){
    res.status(500).json({error:error.message})
}

});



module.exports=router;