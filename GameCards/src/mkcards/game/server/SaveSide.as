package mkcards.game.server 
{
	import flash.system.*;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkcards.json.JSON;
	import mkcards.mysql.Query;
	import mkcards.events.Navigation;
	import mkcards.game.statics.Constants;
	import mkcards.game.statics.Resource;
	import mkcards.game.windows.Preloader;
	
	/**
	 * ...
	 * @author Catfish Studio Games
	 */
	public class SaveSide extends Sprite 
	{
		private var _client:String = "A42F78H363J8004R1";
		
		public function SaveSide() 
		{
			super();
			name = Constants.WINDOW_SAVE_SIDE;
			preloader();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			setData();
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			
			super.dispose();
			System.gc();
			trace("[X] onRemoveFromStage: " + this.name);
		}
		
		private function setData():void 
		{
			var query:Query = new Query();
			var sqlCommand:String = "UPDATE users SET "
								+ "user_side = '" + Resource.userSide + "', "
								+ "user_wins = " + Resource.userWins + ", "
								+ "user_defeats = " + Resource.userDefeats + " "
								+ "WHERE user_uid = '" + Resource.userID + "'";
			
			query.performRequest(Constants.serverPath + "user_set.php?client=" + _client + "&sqlcommand=" + sqlCommand);
			query.addEventListener("complete", onSetDataComplete);
		}
		
		private function onSetDataComplete(e:Object):void 
		{
			removeEventListener("complete", onSetDataComplete);
			if ((e.target.getResult as String) == "complete")
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.ON_SAVE_SIDE_COMPLETE } ));
			}else {
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.ON_ERROR_SET_DATA } ));
			}
		}
		
		private function preloader():void
		{
			if (getChildByName(Constants.WINDOW_PRELOADER) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_PRELOADER));
			}
			else 
			{
				addChild(new Preloader());
			}
		}
		
	}

}