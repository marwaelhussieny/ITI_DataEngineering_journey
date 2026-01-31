use AI

//Find
db.inventory.find({})

//db.inventory.find({WHERE},{Projection = Show and Hide Columns})

//Exclusion False quantity , tags
//SELECT Hide  (quantity , tags) FROM inventory 
db.inventory.find({}, { quantity: 0, tags: 0 })

//Inclusion True quantity , tags
db.inventory.find({}, { quantity: 1, tags: 1 })

//Mix True , False (_id)  //By Defualt True Projection
db.inventory.find({}, { quantity: 1, tags: 1, _id: 0 })

//Mix True , False (Usual Field) 
db.inventory.find({}, { quantity: 1, tags: 0 })


//Find: Not Null Values (inventory :tags)
db.inventory.find({}, { tags: 1, _id: 0 }) //63

//SQL : SELECT tags FROM inventory WHERE tags IS NOT NULL
db.inventory.find({ tags: { $exists: true } }, { tags: 1, _id: 0 }) //36

db.inventory.find({ tags: { $exists: false } }, { tags: 1, _id: 0 }) //27

//Find Data Inside Object (item.name)
db.inventory.find({})
db.inventory.find({ quantity: 30 })

db.inventory.find({ item: "nuts" })

//quantity = 30 (Number)

//find Composite carrier.name : Shipit
db.inventory.find({ "carrier.name": "Shipit" })

//find Composite carrier.fee : 3
db.inventory.find({ "carrier.fee": 1 }, { "carrier.fee": 1 })



//Comparison Operators
//in , $gt (inventory)

db.inventory.find({}, { quantity: 1 })

//quantity>=30
//SQL : SELECT * FROM inventory WHERE  quantity>= 30
db.inventory.find({ quantity: { $gte: 30 } })

db.inventory.find({ quantity: { $gt: 30 } })

//quantity<30
db.inventory.find({ quantity: { $lt: 30 } })


//$in Simple Field (qty) //405 ,25 ,30 ,130
//qty = 25 OR qty = 30   (qty) 
db.inventory.find({ qty: { $exists: true } }, { qty: 1, _id: 0 })

db.inventory.find({ qty: { $in: [25, 30, 130, 405] } })

// Array tags red or blank
db.inventory.find({}, { tags: 1, _id: 0 })

db.inventory.find({ tags: { $in: ["red", "blank"] } })

// Array tags at least red and  blank
db.inventory.find({ tags: { $all: ["red", "blank"] } })


//Logical Operator
//$and , $or
//Find Where Tags in ["red","blank"] and qty Greater Than or Equal 10
db.inventory.find({
    $and: [
        {
            //Tags in ["red","blank"]
            //item : "nuts"
            item: "nuts"
        },
        {
            //qty Greater Than or Equal 10
            qty: { $gte: 10 }
        }
    ]
})

db.inventory.find({
    $and: [
        {
            //Tags in ["red","blank"]
            tags: { $in: ["red", "blank"] }
        },
        {
            //qty Greater Than or Equal 10
            qty: { $gte: 10 }
        }
    ]
})

//Find Where Tags in ["red","blank"] Or qty Greater Than or Equal 90
db.inventory.find({
    $or: [
        {
            //Tags in ["red","blank"]
            tags: { $in: ["red", "blank"] }
        },
        {
            //qty Greater Than or Equal 10
            qty: { $gte: 10 }
        }
    ]
})



//Find Where (tags in ["red","blank"]) and (qty Greater Than or Equal 10 or item journal)
db.inventory.find({
    $and: [
        {
            //tags in ["red","blank"]  
            tags: { $in: ["red", "blank"] }
        },
        {
            //qty Greater Than or Equal 10 or item journal
            $or: [
                {
                    //qty Greater Than or Equal 10
                    qty: { $gte: 10 }
                },
                {
                    //item journal
                    item: "journal"
                }
            ]
        }
    ]
})



//Ignore Case Sensetive (products)
db.products.insertMany([{ item: "ABC" }, { item: "abc" }])

db.products.find({})

db.products.find({ item: "ABC" })

db.products.find({ item: "abc" })


db.products.find({ item: { $regex: "(?i)abc" } })


db.products.find({ item: { $regex: "(?i)ABC" } })


//Update
db.ITI_Banha.find({})

//Update One
//update mona Age = 20 
//SQL : UPDATE ITI_Banha SET age = 20 WHERE _id = 2
//db.ITI_Banha.updateOne({WHERE},{Set Update})

db.ITI_Banha.find({ _id: 2 })

db.ITI_Banha.updateOne({ _id: 2 },
    {
        $set: {
            age: 20
        }
    })

db.ITI_Banha.find({ _id: 2 })

//Update 

//Update Many
db.ITI_Banha.find({})
//Update ali , eman address : "Banha"

db.ITI_Banha.find({ name: { $in: ["ali", "eman"] } })

db.ITI_Banha.updateMany({ name: { $in: ["ali", "eman"] } },
    {
        $set: {
            address: "Banha"
        }
    })

db.ITI_Banha.find({ name: { $in: ["ali", "eman"] } })

//Case
db.ITI_Banha.find({})
//UPDATE ITI_Banha SET status = "VIP"
db.ITI_Banha.updateMany({},  //Alter + Add New Column + Default Value
    {
        $set: {
            status: "VIP"
        }
    })

db.ITI_Banha.find({ "address": "Banha" })

db.ITI_Banha.updateMany({ "address": "Banha" }, {
    $set: {
        address: "cairo"
    }
})

db.ITI_Banha.find({ "address": "cairo" })

db.ITI_Banha.find({ "address": "cairo" })

db.ITI_Banha.updateMany({}, {
    $set: {
        address: "alex"
    }
})

db.ITI_Banha.find({})
// Update Operations ::
//$rename

db.ITI_Banha.updateMany({}, {
    $rename: {
        "dep": "department"
    }
})

//$unset
//drop field status
db.ITI_Banha.updateMany({},
    {
        $unset: {
            status: ""
        }
    })

db.ITI_Banha.updateMany({},
    {
        $unset: {
            age: ""
        }
    })
    
db.ITI_Banha.find({})

db.ITI_Banha.find({ _id: 10 })
db.ITI_Banha.updateOne({ _id: 10 },
    {
        $set: {
            name: "mohamed",
            dep: "SD"
        }
    })

//db.ITI_Banha.updateOne({WHERE}, {SET Update},{Options})
db.ITI_Banha.find({ _id: 10 })

//upsert
db.ITI_Banha.find({ _id: 10 })
db.ITI_Banha.updateOne({ _id: 10 },
    {
        $set: {
            name: "mohamed",
            dep: "SD"
        }
    },
    {
        upsert: true
    })

//db.ITI_Banha.updateOne({WHERE}, {SET Update},{Options})
db.ITI_Banha.find({ _id: 10 }) //WHERE + Update

db.ITI_Banha.find({ name: "malak" })
db.ITI_Banha.updateOne({ name: "malak" },
    {
        $set: {
            address: "alex",
            dep: "SD"
        }
    },
    {
        upsert: true
    })

//db.ITI_Banha.updateOne({WHERE}, {SET Update},{Options})
db.ITI_Banha.find({ name: "malak" }) // WHERE + UPDATE
//_id object + name , address , dep


db.ITI_Banha.find({ name: "noha" })
db.ITI_Banha.updateOne({ name: "noha" },
    {
        $set: {
            _id:15,
            address: "alex",
            dep: "SD"
        }
    },
    {
        upsert: true
    })

//db.ITI_Banha.updateOne({WHERE}, {SET Update},{Options})
db.ITI_Banha.find({ name: "noha" }) // WHERE + UPDATE
//_id object + name , address , dep

//$setOnInsert

db.ITI_Banha.find({ name: "mazen" })
db.ITI_Banha.updateOne({ name: "mazen" },
    {
        $set: {
            _id:20,
            address: "alex",
            dep: "SD",
           //status:"today register"
            
        },
        $setOnInsert:{
            status:"today register"
        }
    },
    {
        upsert: true
    })

//db.ITI_Banha.updateOne({WHERE}, {SET Update},{Options})
db.ITI_Banha.find({ name: "mazen" }) // WHERE + UPDATE + $setOnInsert


db.ITI_Banha.find({ name: "mazen" })
db.ITI_Banha.updateOne({ name: "mazen" },
    {
        $set: {
            
            address: "cairo",
            dep: "AI",            
        },
        $setOnInsert:{
            type:"from upsert"
        }
    },
    {
        upsert: true
    })

//db.ITI_Banha.updateOne({WHERE}, {SET Update},{Options})
db.ITI_Banha.find({ name: "mazen" }) // WHERE + UPDATE + $setOnInsert


// select sum (amount) 
//Where
//group by cust
