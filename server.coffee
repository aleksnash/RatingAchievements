db = require("mysql-native").createTCPClient("127.0.0.1")
db.auto_prepare = true
db.auth('rating','root','')
db.query("select * from users").addListener('row', (r) ->
  console.dir (r)
db.close()

)
###
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
###

express = require('express')
routes = require('./routes')
http = require('http')
path = require('path')

app = express();

# инициализация окружения: выбирается порт,
#директория с представлениями, движком рендеринга, директорией со статическими файлами
app.set('port', process.env.PORT || 8888)
app.set('index2', __dirname + '/views')# тут говорится о месте, где лежат представления
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.bodyParser())
app.use(express.methodOverride())
app.use(app.router)
app.use(express.static(path.join(__dirname, 'public')))

#вывод отладочной информации в режиме отладки
if 'development' == app.get('env')
 app.use(express.errorHandler())


# установка соответствий для каждой страницы (index, index2, index3 - функции, которые определены в файле index.js)
# по-сути routes - это контроллер
app.get('/', routes.index)
app.get('/index2', routes.index2)
app.get('/index3', routes.index3)


# запуск сервера
http.createServer(app).listen(app.get('port'), ()->
console.log('Express server listening on port ' + app.get('port')))






