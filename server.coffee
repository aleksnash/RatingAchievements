sqlite3 = require('sqlite3').verbose()
db = new sqlite3.Database('db.sqlite3')

fs = require('fs')
app = require('http').createServer (req, res) ->
  page = if req.url is '/' then '/index.html' else req.url
  fs.readFile(
    __dirname + page,
  (err, data) ->
    if err
      res.writeHead 500
      res.end "Error loading #{page}"
    else
      res.writeHead 200
      res.end data
  )
io = require('socket.io').listen app
app.listen 12345
###
  END server routine
###

# BEGIN db access
db.serialize( () =>
  db.run("""
         CREATE TABLE IF NOT EXISTS runs (
          runid INTEGER PRIMARY KEY,
          runtime TIMESTAMP
         );
         """)

  db.run("""
         INSERT INTO runs (runtime)
         VALUES (datetime('now'))
         """)

  db.each(
    """
    SELECT runid, runtime
    FROM runs
    """,
    (err, row) =>
      console.log("#{row.runid} : #{row.runtime}")
  )
)
# END db access