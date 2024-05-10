"use strict";

const LSApp = function() {

	return {
		init: function(){
			console.log(`Here`)
		}
	}
}()

document.addEventListener('DOMContentLoaded', function(){
	LSApp.init()
})