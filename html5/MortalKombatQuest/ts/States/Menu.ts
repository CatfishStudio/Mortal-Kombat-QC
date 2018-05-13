module MortalKombatQuest {

    import Tutorial = Fabrique.Tutorial;
    import Settings = Fabrique.Settings;
    import ButtonOrange = Fabrique.ButtonOrange;
    import AnimationBigKen = Fabrique.AnimationBigKen;
    import AnimationBigRyu = Fabrique.AnimationBigRyu;
    import IPersonage = GameData.IPersonage;
    import ICard = GameData.ICard;
    
    export class Menu extends Phaser.State{

        public static Name: string = "menu";
        public name: string = Menu.Name;

        private menuSprite:Phaser.Sprite;
        private groupMenu: Phaser.Group;
        private groupButtons: Phaser.Group;
        
        private buttonContinue:ButtonOrange;
        private buttonStart:ButtonOrange;
        private buttonSettings:ButtonOrange;
        private buttonInvate:ButtonOrange;
        private settings:Settings;

        constructor() {
            super();
        }
        
        public create():void {
            this.initSounds();

            this.groupMenu = new Phaser.Group(this.game, this.stage);
            
            this.menuSprite = new Phaser.Sprite(this.game, 0, 0, Images.MenuImage)
            this.groupMenu.addChild(this.menuSprite);

            let bigKen:AnimationBigKen = new AnimationBigKen(this.game);
            bigKen.scale.setTo(0.4, 0.4);
            bigKen.x = 35;
            bigKen.y = 225;
            this.groupMenu.addChild(bigKen);

            let bigRyu:AnimationBigRyu = new AnimationBigRyu(this.game);
            bigRyu.scale.setTo(0.4, 0.4);
            bigRyu.x = 555;
            bigRyu.y = 225;
            this.groupMenu.addChild(bigRyu);

            this.createButtons();
        }

        public shutdown():void {
            if(this.buttonContinue !== undefined && this.buttonContinue !== null) this.buttonContinue.shutdown();
            this.buttonStart.shutdown();
            this.buttonSettings.shutdown();
            this.buttonInvate.shutdown();
            this.groupMenu.removeAll();
            this.groupButtons.removeAll();
            this.game.stage.removeChildren();
        }

        public initSounds():void{
            // восстановление звука при запуске игры
            this.game.input.onDown.addOnce(() => { 
                this.game.sound.context.resume(); 
            });

            if(GameData.Data.music === undefined || GameData.Data.music === null){
                GameData.Data.music = this.game.add.audio(GameData.Data.musicList[0][0]);
                GameData.Data.buttonSound = this.game.add.audio(Sounds.ButtonSound);
                GameData.Data.arrowSound = this.game.add.audio(Sounds.ArrowSound);
                GameData.Data.flipUpSound = this.game.add.audio(Sounds.CardFlipSound1);
                GameData.Data.flipDownSound = this.game.add.audio(Sounds.CardFlipSound2);
            }else{
                GameData.Data.music.stop();
                GameData.Data.music.key = GameData.Data.musicList[0][0];
            }
            GameData.Data.music.loop = true;
            GameData.Data.music.volume = GameData.Data.musicList[0][1];
            GameData.Data.music.play();
        }

        public createButtons():void {
            this.groupButtons = new Phaser.Group(this.game, this.groupMenu);
            this.groupButtons.x = 300;
            this.groupButtons.y = 300;

            if(GameData.Data.fighterIndex >= 0 && GameData.Data.progressIndex < 20){
                this.buttonContinue = new ButtonOrange(this.game, this.groupButtons, Constants.BUTTON_CONTINUE, 'ПРОДОЛЖИТЬ', 37, 0, -50);
                this.buttonContinue.event.add(this.onButtonClick, this);
            }else{
                SocialVK.vkLoadData(this.onVkDataGet.bind(this));
            }

            this.buttonStart = new ButtonOrange(this.game, this.groupButtons, Constants.BUTTON_PLAY, 'НАЧАТЬ ИГРУ', 35, 0, 0);
            this.buttonStart.event.add(this.onButtonClick, this);

            this.buttonSettings = new ButtonOrange(this.game, this.groupButtons, Constants.BUTTON_SETTINGS, 'НАСТРОЙКИ', 40,  0, 50);
            this.buttonSettings.event.add(this.onButtonClick, this);

            this.buttonInvate = new ButtonOrange(this.game, this.groupButtons, Constants.BUTTON_INVATE, 'ПРИГЛАСИТЬ', 35,  0, 100);
            this.buttonInvate.event.add(this.onButtonClick, this);
        }

        private onVkDataGet(object: any):void {
            Utilits.Data.debugLog('ON VK DATA GET:', object.response.toString());
            if(SocialVK.LoadData(object.response.toString()) === true){
                if(GameData.Data.fighterIndex >= 0 && GameData.Data.progressIndex < 20){
                    this.buttonContinue = new ButtonOrange(this.game, this.groupButtons, Constants.BUTTON_CONTINUE, 'ПРОДОЛЖИТЬ', 37, 0, -50);
                    this.buttonContinue.event.add(this.onButtonClick, this);
                }
            }
        }

        private settingsCreate() {
            this.settings = new Settings(this.game, this.groupMenu);
            this.settings.event.add(this.onButtonClick, this);
        }
        
        private settingsClose() {
            this.settings.removeAll();
            this.groupMenu.removeChild(this.settings);
        }

        private onButtonClick(event):void {
            this.playButtonSound();
            switch (event.name) {
                case Constants.BUTTON_PLAY:
                    {
                        GameData.Data.comixIndex = 0;
                        GameData.Data.progressIndex = -1;
                        GameData.Data.fighterIndex = -1;
                        GameData.Data.tournamentListIds = [];
                        this.game.state.start(ChoiceFighter.Name, true, false);
                        break;
                    }
                case Constants.BUTTON_CONTINUE:
                    {
                        this.game.state.start(Tournament.Name, true, false);
                        break;
                    }
                case Constants.BUTTON_SETTINGS:
                    {
                        this.settingsCreate();
                        break;
                    }
                case Constants.BUTTON_SETTINGS_CLOSE:
                    {
                        this.settingsClose();
                        break;
                    }
                case Constants.BUTTON_INVATE:
                    {
                        SocialVK.vkInvite();
                        break;
                    }                
                default:
                    break;
            }
        }

        private playButtonSound():void {
            if(Config.settingSound){
                GameData.Data.buttonSound.loop = false;
                GameData.Data.buttonSound.volume = 0.5;
                GameData.Data.buttonSound.play();
            }
        }
    }
}