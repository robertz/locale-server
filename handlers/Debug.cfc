component extends="coldbox.system.EventHandler" {

	property name="ContentService" inject;

	function index( event, rc, prc ){
		var qb  = wirebox.getInstance( "QueryBuilder@qb" );
		var res = qb
			.select( "CI.name, LT.code, TI.value" )
			.from( "TranslatedItem TI" )
			.join(
				"ContentItem CI",
				"CI.id",
				"=",
				"TI.contentitemId"
			)
			.join( "LangTypes LT", "LT.id", "=", "TI.langTypeId" )
			.subSelect( "pages", function( q ){
				q.selectRaw( "CONCAT(P.page)" )
					.from( "PageContentItem PCI" )
					.join( "Page P", "P.id", "PCI.pageId" )
					.whereColumn( "PCI.contentItemId", "CI.id" )
			} )
			.orderBy( "CI.name" )
			.get( options = { datasource : "content" } );


		writeDump( var = res, abort = 1 );
	}

	function items( event, rc, prc ){
		writeDump( var = ContentService.listItems(), abort = 1 );
	}

}
