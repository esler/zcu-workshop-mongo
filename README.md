# zcu-workshop-mongo
A workshop about MongoDB. Created for University of West Bohemia. 

### Starting MongoDB
Server
```
mongod --dbpath /tmp

TODO example for windows
```

Client
```
mongo

TODO example for windows
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
