//@ sourceMappingURL=server.map
// Generated by CoffeeScript 1.6.1
(function() {
  var app, db, fs, io, sqlite3,
    _this = this;

  sqlite3 = require('sqlite3').verbose();

  db = new sqlite3.Database('db.sqlite3');

  fs = require('fs');

  app = require('http').createServer(function(req, res) {
    var page;
    page = req.url === '/' ? '/index.html' : req.url;
    return fs.readFile(__dirname + page, function(err, data) {
      if (err) {
        res.writeHead(500);
        return res.end("Error loading " + page);
      } else {
        res.writeHead(200);
        return res.end(data);
      }
    });
  });

  io = require('socket.io').listen(app);

  app.listen(12345);

  /*
    END server routine
  */


  db.serialize(function() {
    db.run("CREATE TABLE IF NOT EXISTS runs (\n runid INTEGER PRIMARY KEY,\n runtime TIMESTAMP\n);");
    db.run("INSERT INTO runs (runtime)\nVALUES (datetime('now'))");
    return db.each("SELECT runid, runtime\nFROM runs", function(err, row) {
      return console.log("" + row.runid + " : " + row.runtime);
    });
  });

}).call(this);
