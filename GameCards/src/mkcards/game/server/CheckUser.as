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
	public class CheckUser extends Sprite 
	{
		private var _client:String = "A42F78H363J8004R1";
		private var _data:Array = [];
		private var _uID:String;
		private var _uName:String;
		private var _uLocation:String;
		private var _uSide:String;
		private var _uWins:int;
		private var _uDefeats:int;
		private var _uMoney:int;
		private var _uFighter:int;
		
		
		public function CheckUser(data:Array) 
		{
			super();
			name = Constants.WINDOW_CHECK_USER;
			
			_data = data;
			_uID = _data[0];
			_uName = _data[1];
			_uLocation = _data[2];
			_uSide = _data[3];
			_uWins = _data[4];
			_uDefeats = _data[5];
			_uMoney = _data[6];
			_uFighter = _data[7];
			preloader();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			getData();
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
			
		private function getData():void 
		{
			var query:Query = new Query();
			var sqlCommand:String = "SELECT * FROM users WHERE (user_uid = '" + _uID + "')";
			query.performRequest(Constants.serverPath + "user_get.php?client=" + _client + "&sqlcommand=" + sqlCommand);
			query.addEventListener("complete", onGetDataComplete);
		}
		
		private function onGetDataComplete(e:Object):void 
		{
			removeEventListener("complete", onGetDataComplete);
			
			var json_str:String = (e.target.getResult as String);
			if (json_str != "" && json_str != "[]")
			{
				var json_data:Array = mkcards.json.JSON.decode(json_str);
				for (var i:Object in json_data) 
				{
					for (var k:Object in json_data[i].user) 
					{
						Resource.userID = json_data[i].user[k].user_uid;
						Resource.userName = json_data[i].user[k].user_name;
						Resource.userLocation = json_data[i].user[k].user_location;
						Resource.userSide = json_data[i].user[k].user_side;
						Resource.userWins = json_data[i].user[k].user_wins;
						Resource.userDefeats = json_data[i].user[k].user_defeats;
						Resource.userMoney = json_data[i].user[k].user_money;
						Resource.userSelectFighter = json_data[i].user[k].user_fighter_select;
					}
				}
				trace(Resource.userName);
				preloader();
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.ON_CHECK_USER_COMPLETE } ));
			} else {
				setData();
			}
		}
		
		private function setData():void 
		{
			var query:Query = new Query();
			var sqlCommand:String = "INSERT INTO users "
								+ "(user_uid, user_name, user_location, user_side, user_wins, user_defeats, user_money, user_fighter_select) VALUES ("
								+ "'" + _uID + "', "
								+ "'" + _uName + "', "
								+ "'" + _uLocation + "', "
								+ "'" + _uSide + "', "
								+ "" + _uWins.toString() + ", "
								+ "" + _uDefeats.toString() + ", "
								+ "" + _uMoney.toString() + ", "
								+ "" + _uFighter.toString() + ")";
			
			query.performRequest(Constants.serverPath + "user_set.php?client=" + _client + "&sqlcommand=" + sqlCommand);
			query.addEventListener("complete", onSetDataComplete);
		}
		
		private function onSetDataComplete(e:Object):void 
		{
			removeEventListener("complete", onSetDataComplete);
			
			if ((e.target.getResult as String) == "complete")
			{
				Resource.userID = _uID;
				Resource.userName = _uName;
				Resource.userLocation = _uLocation;
				Resource.userSide = _uSide;
				Resource.userWins = _uWins;
				Resource.userDefeats = _uDefeats;
				Resource.userMoney = _uMoney;
				Resource.userSelectFighter = _uFighter;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.ON_CHECK_USER_COMPLETE } ));
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