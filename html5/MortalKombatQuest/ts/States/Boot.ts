module MortalKombatQuest {
    export class Boot extends Phaser.State {
        public static Name: string = 'booter';
        public name: string = Boot.Name;
        
        constructor() {
            super();
        }
        
        /*
        * Загружаем ассеты необходимые для прелоадера
        */
        
        public init(): void {
            // отключаем контекстное меню
            this.game.canvas.oncontextmenu = function(e) {
                e.preventDefault();
            }
        }
        
        public preload() {
            this.game.load.image(Images.PreloaderImage, 'assets/images/' + Images.PreloaderImage);
        }
        
        public create() {
            this.game.state.start(Preloader.Name, true, false, {
                nextStage: Menu.Name,
                preloadHandler: (): void => {
                    Images.preloadList.forEach((assetName: string) => {
                        this.game.load.image(assetName, 'assets/images/' + assetName);
                    });
                    
                    /*
                    Atlases.preloadList.forEach((assetName: string) => {
                        this.game.load.atlas(assetName, 'assets/atlas/' + assetName + '.png','assets/atlas/' + assetName + '.json');
                    });

                    Animations.preloadList.forEach((assetName: string) => {
                        this.game.load.json(assetName, 'assets/atlas/'+ assetName);
                    });
                    */
                    
                    /*
                    Sheet.preloadList.forEach((assetName: string) => {
                        this.game.load.spritesheet(assetName, 'assets/images/' + assetName, 186, 46);
                    });
                    */
                    //this.game.load.spritesheet(Sheet.preloadList[0], 'assets/images/' + Sheet.preloadList[0], 186, 46);
                    //this.game.load.spritesheet(Sheet.preloadList[1], 'assets/images/' + Sheet.preloadList[1], 187, 56);
                    //this.game.load.spritesheet(Sheet.preloadList[2], 'assets/images/' + Sheet.preloadList[2], 108, 31);
                    
                    /*
                    Sounds.preloadList.forEach((assetName: string)=>{
                        this.game.load.audio(assetName, ['assets/sounds/'+assetName+'.mp3', 'assets/sounds/'+assetName+'.ogg']);
                    });
                    */
                }
            });
        }
        
        public shutdown(){
            //this.game.stage.removeChildren();
        }
    }
}