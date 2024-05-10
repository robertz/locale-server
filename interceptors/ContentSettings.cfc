component {

	function configure(){
	}

	function preEvent( event ){
		var rc  = event.getCollection();
		var prc = event.getCollection( private = true );

		if ( !client.keyExists( "langCode" ) ) client.langCode = "en";

		prc[ "langCode" ] = client.langCode;
	}

}
