var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var MortalKombatQuest;
(function (MortalKombatQuest) {
    var Game = (function (_super) {
        __extends(Game, _super);
        function Game() {
            _super.call(this, {
                enableDebug: false,
                width: Constants.GAME_WIDTH,
                height: Constants.GAME_HEIGHT,
                renderer: Phaser.AUTO,
                parent: 'content',
                transparent: true,
                antialias: true,
                forceSetTimeOut: false
            });
            this.state.add(MortalKombatQuest.Boot.Name, MortalKombatQuest.Boot, false);
            this.state.add(MortalKombatQuest.Preloader.Name, MortalKombatQuest.Preloader, false);
            this.state.add(MortalKombatQuest.Menu.Name, MortalKombatQuest.Menu, false);
        }
        Game.getInstance = function () {
            if (MortalKombatQuest.Game.instance === null) {
                Game.instance = new Game();
            }
            return Game.instance;
        };
        Game.prototype.start = function () {
            this.state.start(MortalKombatQuest.Boot.Name);
        };
        Game.instance = null;
        return Game;
    }(Phaser.Game));
    MortalKombatQuest.Game = Game;
})(MortalKombatQuest || (MortalKombatQuest = {}));
var Constants = (function () {
    function Constants() {
    }
    Constants.GAME_WIDTH = 860;
    Constants.GAME_HEIGHT = 730;
    Constants.TIMER_END = "timer_end";
    Constants.GAME_OVER = "game_over";
    Constants.BUTTON = 'button';
    return Constants;
}());
var Config = (function () {
    function Config() {
    }
    Config.settingSound = true;
    Config.settingMusic = true;
    Config.settingTutorial = true;
    Config.buildDev = true;
    return Config;
}());
var Images = (function () {
    function Images() {
    }
    Images.PreloaderImage = 'preloader.jpg';
    Images.BackgroundImage = 'background.jpg';
    Images.preloadList = [
        Images.BackgroundImage,
    ];
    return Images;
}());
var Sheet = (function () {
    function Sheet() {
    }
    Sheet.Buttons = 'buttons.png';
    Sheet.preloadList = [
        Sheet.Buttons,
    ];
    return Sheet;
}());
var Utilits;
(function (Utilits) {
    var Data = (function () {
        function Data() {
        }
        /* Debug отладка */
        Data.debugLog = function (title, value) {
            if (Config.buildDev)
                console.log(title, value);
        };
        /* Проверка четности и нечетности */
        Data.checkEvenOrOdd = function (n) {
            if (n & 1) {
                return false; // odd (нечетное число)
            }
            else {
                return true; // even (четное число)
            }
        };
        /* Генератор случайных чисел */
        Data.getRandomIndex = function () {
            var index = Math.round(Math.random() / 0.1);
            return index;
        };
        /* Генератор случайных чисел из диапазона чисел мин/макс */
        Data.getRandomRangeIndex = function (min, max) {
            max -= min;
            var index = (Math.random() * ++max) + min;
            return Math.floor(index);
        };
        /* Функция перемешивает элементы массива */
        Data.compareRandom = function (a, b) {
            return Math.random() - 0.5;
        };
        return Data;
    }());
    Utilits.Data = Data;
})(Utilits || (Utilits = {}));
var Fabrique;
(function (Fabrique) {
    var Button = (function (_super) {
        __extends(Button, _super);
        function Button(game, parent, name, text, textX, x, y) {
            _super.call(this, game, parent);
            this.init(name, text, textX, x, y);
        }
        Button.prototype.shutdown = function () {
            this.removeAll();
        };
        Button.prototype.init = function (name, text, textX, x, y) {
            this.x = x;
            this.y = y;
            this.event = new Phaser.Signal();
            var button = new Phaser.Button(this.game, 0, 0, Sheet.Buttons, this.onButtonClick, this, 1, 2);
            button.name = name;
            button.events.onInputOut.add(this.onButtonInputOut, this);
            button.events.onInputOver.add(this.onButtonInputOver, this);
            this.addChild(button);
            this.textButton = new Phaser.Text(this.game, textX, 15, text, { font: "bold 16px Arial", fill: "#FFFFFF" });
            this.textButton.setShadow(-1, -1, 'rgba(0,0,0,1)', 0);
            this.addChild(this.textButton);
        };
        Button.prototype.onButtonClick = function (event) {
            this.event.dispatch(event);
        };
        Button.prototype.onButtonInputOut = function (event) {
            this.textButton.fill = "#FFFFFF";
            this.textButton.setShadow(-1, -1, 'rgba(0,0,0,1)', 0);
        };
        Button.prototype.onButtonInputOver = function (event) {
            this.textButton.fill = "#2824FF";
            this.textButton.setShadow(-1, -1, 'rgba(255,255,255,1)', 0);
        };
        return Button;
    }(Phaser.Group));
    Fabrique.Button = Button;
})(Fabrique || (Fabrique = {}));
var MortalKombatQuest;
(function (MortalKombatQuest) {
    var Boot = (function (_super) {
        __extends(Boot, _super);
        function Boot() {
            _super.call(this);
            this.name = Boot.Name;
        }
        /*
        * Загружаем ассеты необходимые для прелоадера
        */
        Boot.prototype.init = function () {
            // отключаем контекстное меню
            this.game.canvas.oncontextmenu = function (e) {
                e.preventDefault();
            };
        };
        Boot.prototype.preload = function () {
            this.game.load.image(Images.PreloaderImage, 'assets/image/textures/' + Images.PreloaderImage);
        };
        Boot.prototype.create = function () {
            var _this = this;
            this.game.state.start(MortalKombatQuest.Preloader.Name, true, false, {
                nextStage: MortalKombatQuest.Menu.Name,
                preloadHandler: function () {
                    Images.preloadList.forEach(function (assetName) {
                        _this.game.load.image(assetName, 'assets/image/textures/' + assetName);
                    });
                    Sheet.preloadList.forEach(function (assetName) {
                        _this.game.load.spritesheet(assetName, 'assets/image/textures/' + assetName, 170, 60);
                    });
                }
            });
        };
        Boot.prototype.shutdown = function () {
            //this.game.stage.removeChildren();
        };
        Boot.Name = 'booter';
        return Boot;
    }(Phaser.State));
    MortalKombatQuest.Boot = Boot;
})(MortalKombatQuest || (MortalKombatQuest = {}));
var MortalKombatQuest;
(function (MortalKombatQuest) {
    var Preloader = (function (_super) {
        __extends(Preloader, _super);
        function Preloader() {
            _super.call(this);
            this.name = Preloader.Name;
            this.loadPercent = 0;
        }
        Preloader.prototype.init = function (config) {
            this.config = config;
        };
        Preloader.prototype.preload = function () {
            this.game.add.sprite(0, 0, Images.PreloaderImage);
            this.game.load.onLoadStart.add(this.onLoadStart, this);
            this.game.load.onFileComplete.add(this.onFileComplete, this);
            this.game.load.onLoadComplete.add(this.onLoadComplete, this);
            this.config.preloadHandler();
            if (this.game.load.totalQueuedFiles() === 0) {
                this.onLoadComplete();
            }
        };
        Preloader.prototype.onLoadStart = function () {
            this.preloadText = this.game.add.text(310, 490, "ЗАГРУЗКА 0%", { font: "24px Georgia", fill: "#FFFFFF" });
        };
        Preloader.prototype.onFileComplete = function (progress, cacheKey, success, totalLoaded, totalFiles) {
            this.loadPercent = Math.round(progress * 0.1);
            if (this.loadPercent <= 0)
                this.loadPercent = 1;
            if (this.preloadText !== null) {
                this.preloadText.text = "ЗАГРУЗКА " + this.loadPercent + "0 %";
            }
        };
        Preloader.prototype.onLoadComplete = function () {
            this.game.stage.removeChildren();
            this.game.state.start(this.config.nextStage, true, false);
        };
        Preloader.Name = "preloader";
        return Preloader;
    }(Phaser.State));
    MortalKombatQuest.Preloader = Preloader;
})(MortalKombatQuest || (MortalKombatQuest = {}));
var MortalKombatQuest;
(function (MortalKombatQuest) {
    var Button = Fabrique.Button;
    var Menu = (function (_super) {
        __extends(Menu, _super);
        function Menu() {
            _super.call(this);
            this.name = Menu.Name;
        }
        Menu.prototype.create = function () {
            this.groupMenu = new Phaser.Group(this.game, this.stage);
            this.menuSprite = new Phaser.Sprite(this.game, 0, 0, Images.BackgroundImage);
            this.groupMenu.addChild(this.menuSprite);
            this.createButtons();
        };
        Menu.prototype.shutdown = function () {
            this.button.shutdown();
            this.groupMenu.removeAll();
            this.groupButtons.removeAll();
            this.game.stage.removeChildren();
        };
        Menu.prototype.createButtons = function () {
            this.groupButtons = new Phaser.Group(this.game, this.groupMenu);
            this.groupButtons.x = 300;
            this.groupButtons.y = 300;
            this.button = new Button(this.game, this.groupButtons, Constants.BUTTON, 'КНОПКА', 55, 0, 0);
            this.button.event.add(this.onButtonClick, this);
        };
        Menu.prototype.onButtonClick = function (event) {
            switch (event.name) {
                case Constants.BUTTON:
                    {
                        this.game.state.start(Menu.Name, true, false);
                        console.log("BUTTON CLICK!");
                        break;
                    }
                default:
                    break;
            }
        };
        Menu.Name = "menu";
        return Menu;
    }(Phaser.State));
    MortalKombatQuest.Menu = Menu;
})(MortalKombatQuest || (MortalKombatQuest = {}));
/// <reference path="..\node_modules\phaser-ce\typescript\phaser.d.ts" />
/// <reference path="Data\Constants.ts" />
/// <reference path="Data\Config.ts" />
/// <reference path="Data\Images.ts" />
/// <reference path="Data\Sheets.ts" />
/// <reference path="Data\Utilits.ts" />
/// <reference path="Fabrique\Objects\Button.ts" />
/// <reference path="States\Boot.ts" />
/// <reference path="States\Preloader.ts" />
/// <reference path="States\Menu.ts" />
/// <reference path="app.ts" /> 
