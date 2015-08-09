<?php
	$client = $_GET['client'];
	$sqlcommand = $_GET['sqlcommand'];
	
	if($client == "A42F78H363J8004R1")
	{
		include "config.php";

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$query = mysql_query($sqlcommand, $db);
	
		if(!$query) 
		{
			echo "error";
			mysql_close();
			exit;
		}else {
	
			$index = 0;
			$data_array_json = "[";
		
			while($row = mysql_fetch_array($query))
			{
				if ($index > 0) $data_array_json .= ",{";
				else $data_array_json .= "{";

				$data_array_json .= ""
					."\"id\": "."\"".$row['user_id']."\"".","
					."\"user\": ["
					."{"
						."\"user_uid\": "."\"".$row['user_uid']."\"".","
						."\"user_name\": "."\"".$row['user_name']."\"".","
						."\"user_location\": "."\"".$row['user_location']."\"".","
						."\"user_side\": "."\"".$row['user_side']."\"".","
						."\"user_wins\": "."\"".$row['user_wins']."\"".","
						."\"user_defeats\": "."\"".$row['user_defeats']."\"".","
						."\"user_fighter_select\": "."\"".$row['user_fighter_select']."\"".","
						."\"user_money\": "."\"".$row['user_money']."\""
					."}]}"; 
				$index++;
			}
		}
		mysql_close();
		$data_array_json .= "]";
		echo $data_array_json;
	}
?>