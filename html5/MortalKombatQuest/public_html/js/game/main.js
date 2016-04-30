
/* == START FILE ========================================================= */

var renderer = null;
var mainStage = null;

function onInit()
{
    renderer = PIXI.autoDetectRenderer(860, 730,{backgroundColor : 0xFFFFFF, antialias : false});
    document.body.appendChild(renderer.view);
    
    var game = new Game();
    mainStage = game.getStage();
    game.loadAssets();

    draw();
	
    
    /* Инициализация ВКонтакте */
    /*
    VK.init(function() {
        apiId: 5170657;
    });
    */
}

function draw() 
{
    requestAnimationFrame(draw);
    renderer.render(mainStage);
}

window.addEventListener("load", onInit, false);

/* == END FILE ========================================================== */
