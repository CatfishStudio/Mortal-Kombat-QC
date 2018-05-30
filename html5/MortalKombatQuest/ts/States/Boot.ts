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
            this.game.load.image(Images.PreloaderImage, 'assets/image/textures/' + Images.PreloaderImage);
        }
        
        public create() {
            this.game.state.start(Preloader.Name, true, false, {
                nextStage: Menu.Name,
                preloadHandler: (): void => {
                    Images.preloadList.forEach((assetName: string) => {
                        this.game.load.image(assetName, 'assets/image/textures/' + assetName);
                    });
                    
                    Sheet.preloadList.forEach((assetName: string) => {
                        this.game.load.spritesheet(assetName, 'assets/image/textures/' + assetName, 170, 60);
                    });
                }
            });
        }
        
        public shutdown(){
            //this.game.stage.removeChildren();
        }
    }
}