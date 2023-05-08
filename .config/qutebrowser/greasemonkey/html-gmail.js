// ==UserScript==
// @name        Redirect Gmail to HTML Version
// @namespace   Violentmonkey Scripts
// @match       https://mail.google.com/mail/u/0/
// @match       https://mail.google.com/mail/u/1/
// @grant       none
// @version     1.0
// @author      -
// @description Redirects gmail links to html
// @license MIT
// ==/UserScript==

(function () {
    if(window.location.href.indexOf("u/0/") != -1){
        window.location.href = 'https://mail.google.com/mail/u/0/h' + location.pathname;
    }
    else {
        window.location.href = 'https://mail.google.com/mail/u/1/h' + location.pathname;
    }
})();
