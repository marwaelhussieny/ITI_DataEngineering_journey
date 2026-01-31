use AI //ai

//use ITI_Banha

//Find 
//SQL : SELECT * FROM inventory 
//db.inventory.find({WHERE},{Columns})
db.inventory.find({})

//SQL : SELECT * FROM inventory WHERE qty =130
//db.inventory.find({WHERE},{Columns})
db.inventory.find({ qty: 130 })

db.inventory.find({ _id: 1 })

//SQL : SELECT _id,item,qty FROM inventory WHERE qty =130
//db.inventory.find({WHERE},{Columns})
db.inventory.find({ qty: 130 }, { _id: 1, item: 1, qty: 1 }) //Inclusive Projection True = Show

db.inventory.find({ qty: 130 }, { _id: 0, item: 0, qty: 0 }) //Exclusive Projection False = Hide



//Insert
db.ITI_Banha.insertOne({
    name: "ali",
    age: 15,
    address: "alex"
})

db.ITI_Banha.insertOne({
    _id: 1,
    name: "eman",
    age: 15,
    address: "alex"
})
db.ITI_Banha.find({})

//_id PK          //XXX _Id _ID 

ObjectId()

//Update ITI_Banha SET address="Banha" WHERE _id = 1
//UPDATE 
db.ITI_Banha.find({ _id: 1 })

db.ITI_Banha.find({ _id: ObjectId('68c1ccbab6219b7b22441536') })

db.ITI_Banha.updateOne({ WHERE }, { Update })

db.ITI_Banha.updateOne({ _id: 1 }, {
    $set: {
        address: "Banha",
        age: 15
    }
})

db.ITI_Banha.find({ _id: 1 })
//Delete
//DELETE FROM ITI_Banha WHERE _id = 1
db.ITI_Banha.deleteOne({ _id: 1 })

db.ITI_Banha.find({ _id: 1 })

db.version()

show dbs

