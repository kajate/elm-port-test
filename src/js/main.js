var node = document.getElementById('view');
var app = Elm.Main.embed(node);
// receive something from Elm
app.ports.toJs.subscribe(function (str) {
    console.log("got from Elm:", str);
});

app.ports.sendInterval.subscribe(function (int) {
    console.log("got from Elm:", int);
    if (int <= 49) {
        interval = 50
    }
    else {
        interval = int;
    }
});

var interval = 1000;
var counter = 0

function tick() {
    setTimeout(function () {
        counter++
        app.ports.fromJs.send(counter);
        console.log("tick", interval)
        tick();
    }, interval)
}

tick();