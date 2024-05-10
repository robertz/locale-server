component {

	property name="cache"      inject="cachebox:default";
	property name="ContentDAO" inject;

	function listPages(){
		var cacheKey = "content-pages";
		var pages    = cache.get( cacheKey );
		if ( isNull( pages ) ) {
			pages = ContentDAO.listPagesData();
			cache.set( cacheKey, pages, 120, 20 );
		}
		return pages;
	}

	function listItems(){
		var cacheKey = "content-items";
		var items    = cache.get( cacheKey );
		if ( isNull( items ) ) {
			items = ContentDAO.listItemsData();
			cache.set( cacheKey, items, 120, 20 );
		}
		return items;
	}

	function listAll(){
		return ContentDAO.listAllData();
	}

}
