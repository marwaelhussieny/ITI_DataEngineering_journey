// NoSQL – Mongo Lab 2

use ITI_Mongo

// Using Inventory Collection
// Insert test data if missing
db.inventory.insertMany([
  { item: "paper", qty: 85, tags: ["ssl", "security"], size: { uom: "cm" }, status: "A" },
  { item: "notebook", qty: 50, tags: ["office", "school"], size: { uom: "cm" }, status: "A" },
  { item: "router", qty: 30, tags: ["network", "security"], size: { uom: "cm" }, status: "B" },
  { item: "server", qty: 20, tags: ["ssl", "network"], size: { uom: "cm" }, status: "B" }
])

// 1. Find documents where the "tags" field exists.
db.inventory.find({ tags: { $exists: true } })

// 3. Find documents where "qty" = 85.
db.inventory.find({ qty: 85 })
// SQL Equivalent: SELECT * FROM inventory WHERE qty = 85

// using $eq operator (explicit)
db.inventory.find({ qty: { $eq: 85 } })

// Count matching documents
db.inventory.countDocuments({ qty: 85 })


// 2. Find documents where "tags" does NOT contain "ssl" or "security".

// Method 1: Using $nin (not in) operator
db.inventory.find({
    tags: { $nin: ["ssl", "security"] }
})
//match documents when tag is missing or null
// Method 2: Using $not with $in
db.inventory.find({
    tags: { $not: { $in: ["ssl", "security"] } }
})
//Does not match documents where tags is missing


// Method 3: Using $nor (neither ssl nor security)
db.inventory.find({
    $nor: [
        { tags: "ssl" },
        { tags: "security" }
    ]
})
//behave like nin
//when combining multiple full conditions



// 4. Find documents where tags contains ALL values [ssl, security].

// where the tags array contains both "ssl" and "security"
// Using $all operator - tags must contain  values
db.inventory.find({
    tags: { $all: ["ssl", "security"] }
})

// This is equivalent to using $and:
db.inventory.find({
    $and: [
        { tags: "ssl" },
        { tags: "security" }
    ]
})
//Purpose-built for arrays so can behave differently if tags is not an array



// 4.a If you need ONLY the two values "ssl" and "security"
//find documents where tags contains exact these two values 
// Method 1: Exact array match (order matters)
db.inventory.find({
    tags: ["ssl", "security"]
})

// Method 2: Exact array match (order doesn't matter) - Custom approach
// Find documents with exactly 2 tags, both being ssl and security
db.inventory.find({
    $and: [
        { tags: { $all: ["ssl", "security"] } },
        { tags: { $size: 2 } }
    ]
})


// 5. Update "paper" document
// Update size.uom to "meter" and add current date
db.inventory.updateOne(
  { item: "paper" }, //for filteration
  {
    $set: { "size.uom": "meter" },//update nested field
    $currentDate: { lastModified: true } //set to current date
  }
)
// Verify the update
db.inventory.find({ item: "paper" })

// 5.a Upsert using filter item: "laptopDevice"
// Upsert operation with $setOnInsert
db.inventory.updateOne(
    { item: "laptopDevice" },  // Filter (doesn't exist)
    {
        $set: {
            "size.uom": "meter",
            qty: 50,
            status: "A"
        },
        $setOnInsert: {
            dataSource: "todayRegister",  // Only set if INSERT occurs
            createdAt: new Date(),
            category: "Electronics"
        },
        $currentDate: {
            lastModified: true
        }
    },
    { upsert: true }  // Create if doesn't exist
)

// Verify the new document
db.inventory.find({ item: "laptopDevice" })


// 5.b Use updateMany
//without filter 
db.inventory.updateMany({}, { $set: { status: "checked" } })
//with filters
db.inventory.updateMany(
    { qty: { $lt: 50 } },  // Filter: quantity less than 50
    {
        $set: {
            status: "Low Stock",
            needsReorder: true
        },
        $currentDate: {
            lastModified: true
        }
    }
)

// Verify updates
db.inventory.find(
    { qty: { $lt: 50 } },
    { item: 1, qty: 1, status: 1, needsReorder: 1 }
)

// 5.c Use replaceOne
db.inventory.replaceOne(
  { item: "notebook" },
  { item: "notebook", qty: 200, status: "replaced" }
)
db.inventory.find({ item: "notebook" })

// 6. Insert wrong fields then rename them
db.inventory.insertOne({ neme: "Ali", ege: 25 })

db.inventory.find({ ege:25 })

db.inventory.updateOne(
  { neme: "Ali" },
  { $rename: { "neme": "name", "ege": "age" } }
)

// 7. Reset a field using $unset
db.inventory.updateOne(
  { item: "paper" },
  { $unset: { status: "" } }
)

// Rename multiple fields across all documents
db.inventory.updateMany(
    {},  // All documents
    {$rename: {
            "nmae": "name",  // Fix common typo
            "addres": "address"}})

// 8. Update operators ($max, $min, $inc, $mul)

// Insert test document if not existing
db.inventory.insertOne({
  name: "Employee1",
  salary: 5000,
  overtime: 10,
  age: 25,
  quantity: 4,
  price: 20
})

// Use $max on salary
db.inventory.updateOne({}, { $max: { salary: 6000 } })

// Use $min on overtime
db.inventory.updateOne({}, { $min: { overtime: 5 } })

// Use $inc on age
db.inventory.updateOne({}, { $inc: { age: 1 } })

// Use $mul on quantity and price
db.inventory.updateOne({}, { $mul: { quantity: 2, price: 1.5 } })

// 9. Total revenue from sales collection (2020–2023)

// Insert sales test data if missing
db.sales.insertMany([
  { product: "Laptop", quantity: 2, price: 1000, date: ISODate("2021-05-10") },
  { product: "Laptop", quantity: 1, price: 1200, date: ISODate("2022-06-15") },
  { product: "Phone", quantity: 5, price: 500, date: ISODate("2020-07-20") }
])

db.sales.aggregate([
  {
    $match: {
      date: {
        $gte: ISODate("2020-01-01"),
        $lte: ISODate("2023-01-01")
      }
    }
  },
  {
    $project: {
      product: 1,
      revenue: { $multiply: ["$quantity", "$price"] }
    }
  },
  {
    $group: {
      _id: "$product",
      totalRevenue: { $sum: "$revenue" }
    }
  },
  { $sort: { totalRevenue: -1 } }
])

// 10. Average salary per department
// Insert employees test data if missing
db.employees.insertMany([
  { name: "Ali", department: "IT", salary: 6000 },
  { name: "Sara", department: "IT", salary: 8000 },
  { name: "Omar", department: "HR", salary: 5000 }
])

db.employees.aggregate([
  {
    $group: {
      _id: "$department",
      avgSalary: { $avg: "$salary" }
    }
  }
])
//11. Use likes Collection to calculate max and min likes per title
db.likes.aggregate([
  {
    $group: {
      _id: "$title",
      maxLikes: { $max: "$likes" },
      minLikes: { $min: "$likes" }
    }
  }
])
