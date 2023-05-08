// ==UserScript==
// @name         YouTube Home Clear
// @description  Allows for changing of yt.config_ values
// @license      Unlicense
// @match        *://*.youtoob.com
// @match        *://*.youtoob.com/
// @icon         https://www.youtube.com/favicon.ico
// @grant        none
// ==/UserScript==


(function() {
    'use strict';
    const observer = new MutationObserver(function(mutations) {
        const elem = document.getElementById('contents');
        elem.remove();
    });
    observer.observe(document, {
        childList: true,
        subtree: true
    });
})();
