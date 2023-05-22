// ==UserScript==
// @name        Redirect Youtube to piped Version
// @namespace   Violentmonkey Scripts
// @match       *://*.youtube.com/*
// @grant       none
// @version     1.0
// @author      -
// @license MIT
// ==/UserScript==

(function () {
  'use strict';

  if (window.location.href.match(/^https?:\/\/www.youtube\.com\/watch\?v=[A-Za-z0-9]*/)) {
    window.location.replace("https://piped.video" + window.location.href.substr(23, 44));
  }
})();
