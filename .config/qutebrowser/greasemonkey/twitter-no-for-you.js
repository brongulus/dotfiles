// ==UserScript==
// @name         Twitter - No more for you
// @version      1.0
// @match       https://twitter.com/*
// @match       https://mobile.twitter.com/*
// @exclude     https://twitter.com/en/*
// @exclude     https://mobile.twitter.com/en/*
// @exclude     https://twitter.com/ja/*
// @exclude     https://mobile.twitter.com/ja/*
// @exclude     https://twitter.com/account/*
// @exclude     https://mobile.twitter.com/account/*
// @exclude     https://twitter.com/intent/*
// @exclude     https://mobile.twitter.com/intent/*
// @exclude     https://twitter.com/share?*
// @exclude     https://mobile.twitter.com/share?*
// @exclude     https://twitter.com/i/cards/*
// @exclude     https://mobile.twitter.com/i/cards/*
// @description  Stay on your Following instead of the promoted algorithm "For you" page
// @author       https://github.com/rico-vz
// @icon         https://www.google.com/s2/favicons?sz=64&domain=https://twitter.com/Zqrc
// @grant        none
// @namespace https://greasyfork.org/users/1022850
// ==/UserScript==
(function() {
    'use strict';

    const observer = new MutationObserver(function(mutations) {
        const tabs = Array.from(document.querySelectorAll('[role="tab"][href="/home"]'));
        tabs[0].style.display = 'none';
        tabs[1].style.display = 'none';
        document.querySelector('[aria-label*="Timeline: Trending now" i]').style.display = 'none';
    });


    observer.observe(document, {
        childList: true,
        subtree: true
    });
})();
