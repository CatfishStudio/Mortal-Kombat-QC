<?php
	$server = $_POST['server'];
	$uid = $_POST['uid'];
	$pass = $_POST['pass'];
	$database = $_POST['database'];
	
	$create = $_GET['create'];
	
	if($create == null)
	{
		echo "<h1>Information system QA</h1>";
		echo "<h2>Create database:</h2>";
		echo "<form action='index.php?create=database' method='post'>";
		echo "<label for='server'>Server:</label><br><input type='text' name='server' id='server' value='localhost'><br>";
		echo "<label for='database'>Database:</label><br><input type='text' name='database' id='database' value='mkcards'><br>";
		echo "<label for='Uid'>uid:</label><br><input type='text' name='uid' id='uid' value='root'><br>";
		echo "<label for='pass'>Pass:</label><br><input type='password' name='pass' id='pass' value=''><br>";
		echo "<br><input type='submit' value='Create database' id='bottonGo'>";
		echo "</form>";
		echo "<br><br>";
		echo "<h2>Create tables:</h2>";
		echo "<form action='index.php?create=tables' method='post'>";
		echo "<label for='server'>Server:</label><br><input type='text' name='server' id='server' value='localhost'><br>";
		echo "<label for='database'>Database:</label><br><input type='text' name='database' id='database' value='mkcards'><br>";
		echo "<label for='Uid'>uid:</label><br><input type='text' name='uid' id='uid' value='root'><br>";
		echo "<label for='pass'>Pass:</label><br><input type='password' name='pass' id='pass' value=''><br>";
		echo "<br><input type='submit' value='Create tables' id='bottonGo'>";
		echo "</form>";
	}else{
	
		if($create == "database")
		{
			/* Соединение с сервером баз данных */
			$db = mysql_connect($server, $uid, $pass);
			/* Запрос на создание базы данных  */
			$query = mysql_query("CREATE DATABASE ".$database, $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Database not create!";
				exit;
			}else{
				echo "<br><br>Database created!";
			}
			
			echo "<br><br>";
			echo "<form action='index.php' method='post'>";
			echo "<input type='submit' value='Back' id='back'>";
			echo "</form>";
		}
		/*--------------------------------------------------*/
		
		if($create == "tables")
		{
			/* Соединение с сервером баз данных */
			$db = mysql_connect($server, $uid, $pass);
			/*Соединение с базой данных*/
			mysql_select_db($database, $db);
		
			/*Создание таблицы ПОЛЬЗОВАТЕЛИ (users) ========= */
			$query = mysql_query("CREATE TABLE users (
				user_id int(7) NOT NULL AUTO_INCREMENT,
				user_uid varchar(255) NOT NULL,
				user_name varchar(255) NOT NULL,
				user_location varchar(255) NOT NULL,
				user_side varchar(10) NOT NULL,
				user_wins int(7) NOT NULL DEFAULT '0',
				user_defeats int(7) NOT NULL DEFAULT '0',
				user_money int(7) NOT NULL DEFAULT '0',
				user_fighter_select int(2) NOT NULL DEFAULT '0',
				PRIMARY KEY (user_id),
				UNIQUE KEY system_users_login (user_uid)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"users\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"users\" - complete!";
			}
			/*==================================================================*/
	
			
			/*Создание таблицы БОЙЦЫ (fighters) =========== */
			$query = mysql_query("CREATE TABLE fighters (
				fighter_id int(10) NOT NULL AUTO_INCREMENT,
				fighter_user_uid varchar(255) NOT NULL,
				fighter_name varchar(255) NOT NULL,
				PRIMARY KEY (fighter_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"fighters\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"fighters\" - complete!";
			}
			/*==================================================================*/
			
			/*Создание таблицы КОЛОДЫ КАРТ (deck_cards) =========== */
			$query = mysql_query("CREATE TABLE deck_cards (
				deck_card_id int(10) NOT NULL AUTO_INCREMENT,
				deck_card_user_uid varchar(255) NOT NULL,
				deck_card_fighter_id int(10) NOT NULL DEFAULT '0',
				deck_card_name varchar(255) NOT NULL,
				deck_card_type varchar(255) NOT NULL,
				deck_card_view varchar(255) NOT NULL,
				deck_card_HP int(3) NOT NULL DEFAULT '0',
				deck_card_number_actions int(3) NOT NULL DEFAULT '0',
				deck_card_power int(3) NOT NULL DEFAULT '0',
				deck_card_MP int(3) NOT NULL DEFAULT '0',
				PRIMARY KEY (deck_card_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"deck_cards\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"deck_cards\" - complete!";
			}
			/*==================================================================*/
			
			echo "<br><br>";
			echo "<form action='index.php' method='post'>";
			echo "<input type='submit' value='Back' id='back'>";
			echo "</form>";
		}
	}
?>