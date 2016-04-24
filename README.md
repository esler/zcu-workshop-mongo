# zcu-workshop-mongo
A workshop about MongoDB. Created for University of West Bohemia.

### Starting MongoDB
Server
```
# linux
mongod --dbpath /data/db

# windows
mongod.exe --dbpath D:\Database\MongoDB\data
```

Client
```
# linux
mongo

# windows
mongo.exe
```

### Creating database
```javascript
use friendface
```

### Inserting documents
Syntax: `db.<collection-name>.insert(<document>)`
```javascript
// INSERT INTO users (username, name, sex, age) VALUES ('jon.doe', 'Jon Doe', 'male', 34);
db.users.insert({"username":"jon.doe","name":"Jon Doe","sex":"male","age":34);
db.users.insert({"username":"elison_heart","name":"Elison Heart","sex":"female","age":18);

// it's not problem to change schema - because there's not schema
db.users.insert({"username":"fanda","name":"František Vopršálek","sex":"Příležitostně", "hobbies":["NoSQL","BigData","pivo"]);

// it's possible to nest documents
db.users.insert({"username":"jim.kirk","name":"James T. Kirk","setup":{"subscribe":true,"email":"jtk@enterprise.space"}});
```
MongoDB automatically creates field `_id` (equivalent to auto-increment in MySQL)

### Querying documents
Syntax: `db.<collection-name>.find([<query-document>],[<select-document>])`
```javascript
// SELECT * FROM users;
db.users.find();

// SELECT * FROM users WHERE username = 'fanda';
db.users.find({"username":"fanda"});

// SELECT * FROM users WHERE age < 20;
db.users.find({"age":{"$lt": 20}});

// SELECT username FROM users WHERE sex IN ('male','female');
db.users.find({"sex":{"$in":["male","female"]}});

// SELECT * FROM users LIMIT 1;
db.users.find().limit(1);

// SELECT * FROM users ORDER BY age DESC,name;
db.users.find().sort({"age":-1,"name":1});
```

### Modifying documents
Syntax: `db.<collection-name>.update(<query-document>,<set-document>);`
```javascript
// UPDATE users SET age = 35 WHERE username = 'jon.doe';
db.users.update({"username":"jon.doe"},{"$set":{"age":35}});
```

### Removing documents
Syntax: `db.<collection-name>.remove(<query-document>);`
```javascript
// DELETE FROM users WHERE age >= 50;
db.users.remove({"age":{"$gte":50}});
```
### Importing collections
```
# linux
mongoimport --db friendface --collection users < users.json

# windows
mongoimport.exe /d friendface /c users /file users.json
```

### Indexes
Syntax: `db.<collection-name>.ensureIndex(<index-document>);`
```javascript
// simple index
db.users.ensureIndex({"username":1});

// compound index
db.users.ensureIndex({"username":1, age: 1});
```

### Aggregation

#### Aggregation pipeline
![example image](https://docs.mongodb.org/manual/_images/aggregation-pipeline.png "Aggregation pipeline example")
```javascript
# count average age by gender
db.users.aggregate([
    {"$group":{"_id":"$sex","average":{"$avg":"$age"}}}
]);
```

#### Map-Reduce
![example image](https://docs.mongodb.org/manual/_images/map-reduce.png "Map-Reduce example")
```javascript
# map name (first name and last name separately) as key, value always 1
var map = function () {
    this.name.split(' ').forEach(function (name) {
        emit(name, 1);
    });
};

# sum up all given values
var reduce = function (key, values) {
    return Array.sum(values);
}

db.users.mapReduce(map, reduce, {"out":"users_names"});
```

### This repo
http://bit.ly/23SY4Na

### Sources
- https://docs.mongodb.org/
