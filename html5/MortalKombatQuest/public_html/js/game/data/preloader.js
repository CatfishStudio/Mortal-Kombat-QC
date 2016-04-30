
/* == START FILE ========================================================= */

function Preloader()
{
    this.stage = new PIXI.Container();
    this.styleText = { font : 'bold 48px Arial', fill : '#FFFFFF', stroke : '#000000', strokeThickness : 1, wordWrap : true, wordWrapWidth : 600 };
    this.progressText = null;
    this.percentSounds = 0;
    this.percentTextures = 0;
    this.complete = 0;
    this.assets =  new Object();
}

Preloader.prototype = {
    constructor: Preloader,
    
    getStage: function()
    {
        return this.stage;
    },
    
    removeStage: function()
    {
        for(var child in this.stage.children) this.stage.removeChild(this.stage.children[child]);
        return this.stage;
    },
    
    destroyStage: function()
    {
        this.stage.destroy();
    },
    
    startLoad: function() 
    {
        var loader = new PIXI.loaders.Loader();
        loader.add('preloaderTexture',"./assets/image/textures/preloader.jpg");
        loader.once('complete', this.onLoaderComplete.bind(this));
        loader.load();
        loader = null;
    },
    
    onLoaderComplete: function(loader, res)
    {
        var sprite = new PIXI.Sprite(res.preloaderTexture.texture);
        sprite.position.x = 0; 
        sprite.position.y = 0; 
        this.stage.addChild(sprite);
        this.loadProgressShow();
        
        sprite = null;
    },
    
    loadProgressShow: function()
    {
        this.progressText = new PIXI.Text("Загрузка", this.styleText); 
        this.progressText.x = 280;
        this.progressText.y = 550;
        this.stage.addChild(this.progressText);
        
        //that.loadSounds();
        this.loadAssets();
    },

    loadAssets: function()
    {
        var loader = new PIXI.loaders.Loader();
        loader.add('bgImage','./assets/image/textures/background.jpg');
        loader.add('buttonImage','./assets/image/textures/button.png');
        loader.add('blueportalImage','./assets/image/texture/blueportal.png');
        loader.add('borderImage','./assets/image/texture/border_screen.png');
        loader.add('gameAtlas','./assets/image/atlas/game.json');
        loader.add('bloodAtlas','./assets/image/atlas/blood.json');
        loader.add('drugonAtlas','./assets/image/atlas/drugon.json');
        loader.add('flashAtlas','./assets/image/atlas/flash.json');
        loader.add('levelsAtlas','./assets/image/atlas/levels.json');
        loader.add('barakaAtlas','./assets/image/atlas/baraka.json');
        loader.add('goroAtlas','./assets/image/atlas/goro.json');
        loader.add('jaxAtlas','./assets/image/atlas/jax.json');
        loader.add('johnnycageAtlas','./assets/image/atlas/johnnycage.json');
        loader.add('kitanaAtlas','./assets/image/atlas/kitana.json');
        loader.add('kunglaoAtlas','./assets/image/atlas/kunglao.json');
        loader.add('liukangAtlas','./assets/image/atlas/liukang.json');
        loader.add('mileenaAtlas','./assets/image/atlas/mileena.json');
        loader.add('raidenAtlas','./assets/image/atlas/raiden.json');
        loader.add('reptileAtlas','./assets/image/atlas/reptile.json');
        loader.add('scorpionAtlas','./assets/image/atlas/scorpion.json');
        loader.add('shangtsungAtlas','./assets/image/atlas/shangtsung.json');
        loader.add('shaokahnAtlas','./assets/image/atlas/shaokahn.json');
        loader.add('subzeroAtlas','./assets/image/atlas/subzero.json');
        loader.add('level0','./assets/data/levels/level0.json');
        loader.add('level1','./assets/data/levels/level1.json');
        loader.add('level2','./assets/data/levels/level2.json');
        loader.add('level3','./assets/data/levels/level3.json');
        loader.add('level4','./assets/data/levels/level4.json');
        loader.add('level5','./assets/data/levels/level5.json');
        loader.add('level6','./assets/data/levels/level6.json');
        loader.add('level7','./assets/data/levels/level7.json');
        loader.add('level8','./assets/data/levels/level8.json');
        loader.add('level9','./assets/data/levels/level9.json');
        loader.add('level10','./assets/data/levels/level10.json');
        loader.add('level11','./assets/data/levels/level11.json');
        loader.add('level12','./assets/data/levels/level12.json');
        loader.add('level13','./assets/data/levels/level13.json');
        loader.on('progress', this.onAssetsLoaderProcess.bind(this));
        loader.on('complete', this.onAssetsLoaderComplete.bind(this));
        loader.load();
        loader = null;
    },

    onAssetsLoaderProcess: function()
    {
        this.percentTextures = (Math.round(this.progress) / 2);
        this.progressText.text = "Загрузка " + (this.percentTextures + this.percentSounds) + "%";
    },

    onAssetsLoaderComplete: function(loader, res)
    {
        this.percentTextures = 50;
        this.progressText.text = "Загрузка " + (this.percentTextures + this.percentSounds) + "%";
            
        this.assets["bgTexture"] = res.bgImage.texture;
        this.assets["buttonTexture"] = res.buttonImage.texture;
        this.assets["borderTexture"] = res.borderImage.texture;
        this.assets["blueportalTexture"] = res.blueportalImage.texture;

        this.assets["buttonPlusTextures"] = PIXI.Texture.fromFrame('character_button_plus.png');
        this.assets["bgCharacterWindowTexture"] = PIXI.Texture.fromFrame('character_background_small.png');
    }
};

/* == END FILE ========================================================== */
