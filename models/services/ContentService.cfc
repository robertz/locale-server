component {

	property name="cache" inject="cachebox:default";

	function listPages(){
		var cacheKey = "content-pages";
		var pages    = cache.get( cacheKey );
		if ( isNull( pages ) ) {
			var qb = wirebox.getInstance( "QueryBuilder@qb" );
			pages  = qb
				.select( "*" )
				.from( "Page" )
				.get( options = { datasource : "Content" } );
			cache.set( cacheKey, pages, 120, 20 );
		}

		return pages;
	}

	function listItems(){
		var cacheKey = "content-items";
		var items    = cache.get( cacheKey );
		if ( isNull( items ) ) {
			var qb = wirebox.getInstance( "QueryBuilder@qb" );
			items  = qb
				.select( "*" )
				.from( "ContentItem" )
				.get( options = { datasource : "Content" } );
			cache.set( cacheKey, items, 120, 20 );
		}

		return items;
	}

	function listAll(){
		var qb  = wirebox.getInstance( "QueryBuilder@qb" );
		var res = qb
			.select( "CI.name, LT.code, TI.value" )
			.from( "TranslatedItem TI" )
			.join(
				"ContentItem CI",
				"CI.id",
				"=",
				"TI.contentItemId"
			)
			.join( "LangTypes LT", "LT.id", "=", "TI.langTypeId" )
			.subSelect( "pages", function( q ){
				q.selectRaw( "CONCAT(P.page)" )
					.from( "PageContentItem PCI" )
					.join( "Page P", "P.id", "=", "PCI.pageId" )
					.whereColumn( "PCI.contentItemId", "CI.id" )
			} )
			.orderBy( "CI.name" )
			.get( options = { datasource : "content" } );

		return res;
	}

}
