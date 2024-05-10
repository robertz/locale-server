component {

	property name="settings" inject="coldbox:modulesettings:cbcontent";
	property name="wirebox"  inject;

	/**
	 * Retrieve all content pages
	 *
	 * @return query
	 */
	function listPagesData(){
		var qb  = wirebox.getInstance( "QueryBuilder@qb" );
		var res = qb
			.select( "*" )
			.from( "Page" )
			.get( options = { datasource : settings.datasource } );

		return res;
	}

	/**
	 * Retrieve all content items
	 *
	 * @return query
	 */
	function listItemsData(){
		var qb  = wirebox.getInstance( "QueryBuilder@qb" );
		var res = qb
			.select( "*" )
			.from( "ContentItem" )
			.get( options = { datasource : settings.datasource } );

		return res;
	}

	/**
	 * Retrieve all pages, content items, and translations
	 *
	 * @return query
	 */
	function listAllData(){
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
			.get( options = { datasource : settings.datasource } );

		return res;
	}

}
