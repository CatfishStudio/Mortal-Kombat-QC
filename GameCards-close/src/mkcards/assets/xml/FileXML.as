package mkcards.assets.xml 
{
	import flash.utils.ByteArray;
	
	public class FileXML
	{
		
		public static function getFileXML(classFileXML:Class):XML
		{
			var byteArray:ByteArray = new classFileXML();
			return new XML(byteArray.readUTFBytes(byteArray.length));
		}
	}

}