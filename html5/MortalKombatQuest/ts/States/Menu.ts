module MortalKombatQuest {

    import Button = Fabrique.Button;
    
    export class Menu extends Phaser.State{

        public static Name: string = "menu";
        public name: string = Menu.Name;

        private menuSprite:Phaser.Sprite;
        private groupMenu: Phaser.Group;
        private groupButtons: Phaser.Group;
        
        private button:Button;
       
        constructor() {
            super();
        }
        
        public create():void {
            this.groupMenu = new Phaser.Group(this.game, this.stage);
            
            this.menuSprite = new Phaser.Sprite(this.game, 0, 0, Images.BackgroundImage)
            this.groupMenu.addChild(this.menuSprite);

            this.createButtons();
        }

        public shutdown():void {
            this.button.shutdown();
            this.groupMenu.removeAll();
            this.groupButtons.removeAll();
            this.game.stage.removeChildren();
        }

        public createButtons():void {
            this.groupButtons = new Phaser.Group(this.game, this.groupMenu);
            this.groupButtons.x = 300;
            this.groupButtons.y = 300;

            this.button = new Button(this.game, this.groupButtons, Constants.BUTTON, 'КНОПКА', 55, 0, 0);
            this.button.event.add(this.onButtonClick, this);
        }

        private onButtonClick(event):void {
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
        }

        
    }
}