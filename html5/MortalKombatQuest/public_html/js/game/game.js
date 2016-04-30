
/* == START FILE ========================================================= */

function Game()
{
    this.stage = new PIXI.Container();
    this.assets = null;
}

Game.prototype = {
    constconstructor: Game,
    config: {music:true, sound:true, language:"rus", control: 0, MAIN_WIDTH:860, MAIN_HEIGH:730},

    getStage: function()
    {
        return this.stage;
    },
  
    loadAssets: function()
    {
        var preloader = new Preloader();
        this.stage.addChild(preloader.getStage());
        preloader.startLoad();
        
        preloader = null;
    }
};

/* == END FILE ========================================================== */
