var express = require('express')
var app = express()
var bodyParser = require('body-parser');
var fs = require('fs');

app.use(express.static('public'));
var jsonParser = bodyParser.json();
app.use(bodyParser.urlencoded({extended: false}));
app.get('/', function (req, res) {
    res.send('Hello World')
})

app.post('/level', jsonParser, function (req, res) {
    saveData(req.body.levelData);
    res.send("ok");
});

function saveData(dataStr) {
    var data = JSON.parse(dataStr);
    var len = data.length;
    for (var i = 0; i < len; i++) {
        fs.writeFile("level/level" + (i + 1) +".json", JSON.stringify(data[i]), function (err) {
            if (err) {
                return console.error(err);
            }
            console.log("已保存");
        });
    }
}

app.listen(3000);