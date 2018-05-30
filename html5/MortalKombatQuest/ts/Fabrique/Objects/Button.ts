module Fabrique {
    export class Button extends Phaser.Group {
        public event: Phaser.Signal;
        private textButton:Phaser.Text;
        
        constructor(game:Phaser.Game, parent:Phaser.Group, name:string, text:string, textX:number, x:number, y:number){
            super(game, parent);
            this.init(name, text, textX, x, y);
        }

        public shutdown():void {
            this.removeAll();
        }

        private init(name:string, text:string, textX:number, x:number, y:number):void{
            this.x = x;
            this.y = y;

            this.event = new Phaser.Signal();

            let button = new Phaser.Button(this.game, 0, 0, Sheet.Buttons, this.onButtonClick, this, 1, 2);
            button.name = name;
            button.events.onInputOut.add(this.onButtonInputOut, this);
            button.events.onInputOver.add(this.onButtonInputOver, this);
            this.addChild(button);

            this.textButton = new Phaser.Text(this.game, textX, 15, text, {font: "bold 16px Arial", fill: "#FFFFFF"});
            this.textButton.setShadow(-1, -1, 'rgba(0,0,0,1)', 0);
            this.addChild(this.textButton);
        }

        private onButtonClick(event) {
            this.event.dispatch(event);
        }

        private onButtonInputOut(event){
            this.textButton.fill = "#FFFFFF";
            this.textButton.setShadow(-1, -1, 'rgba(0,0,0,1)', 0);
        }

        private onButtonInputOver(event){
            this.textButton.fill = "#2824FF";
            this.textButton.setShadow(-1, -1, 'rgba(255,255,255,1)', 0);
        }
    }
}
