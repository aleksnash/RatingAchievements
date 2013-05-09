
# берем представление index и подставляем туда переменную title
exports.index = (req, res)->
 res.render('index', { title: 'Рейтинг достижений'} )


# вызываем функцию init из файла index2.js
require('./index2').init(exports)

exports.index3 = (req, res)->
# берем представление index и подставляем туда переменную title
 res.render('index', { title: 'This is index 3'} )
