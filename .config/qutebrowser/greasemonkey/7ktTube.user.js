// ==UserScript==
// @name			7ktTube | 2016 REDUX
// @namespace STILL_ALIVE
// @version         4.2.4
// @description     Old YouTube 2016 Layout | Old watchpage | Change thumbnail & video player size | grayscale seen video thumbnails | Hide suggestion blocks, category/filter bars | Square profile-pictures | Disable hover thumbnail previews | and much more!
// @author          7KT-SWE
// @icon            data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAMAAADVRocKAAACnVBMVEUAAAD////////94+PX19f+8fH/////////+fn83Nz////////////////////////////////////////////////////////////829vS0tL////////////////////////////////////////////////y8vLp6en95+f////////////sKCgAAADpCQnqDg7pBgbqCwvsHh7sICDsIyPtKirsJibrGhr1kZHyaGjrGBjnAAD81tbrHBz3oqLsJSXxX1/qEBDp6enxZGSysrIVFRX2k5PxWVnqEhK0tLT1gYHtLCzqFBTybW3wUlLtMDDtMjLz8/PuOzvqFxcHBwf95eX0iIjxYGDvQEDpAQF/f3/wU1PuNTX+7e394+PuODgfHx///f3+9PT6xMT4qKilpaX1i4v82dnvR0f/+vr+8vLj5OT2nJzzcnLzcHDwS0vvRETrFRXx8fH7z8/5urrsk5N2dnbxVlbwT08iIiL83d380dH7ycmqqqr1jo70fHx0dHT7JSX6+vr39/f/9vb+8/P+6ur83Nz71NTR0dH5tLT3paX2mZn1iIj1hYXxXFwFBQXNzc33r6/3n5+JiYmFhYV6enrzeHhJSUkiPDzpDw8LDAz95+f7zc36vr68vLyUlJTzdXVra2vyamo0NDTrJib8ICD5Hh4dHR0RERHf39/Y2Nj7zs7Gxsb6v7+2trbvra2Xl5eQkJDybGxeXl5XV1dMTExHR0c7OzsdNjYuLi4SLS38KiopKSn9/Pzv+vr839+8yMj5wMDxuLi4uLj4qqruqqqgoKB8fHwGICDyFxfsFhbV4uL7y8vyx8f6wMCvvb3tt7e3t7eur6+Yr6+OpaXuoKA2U1NRUVE0UVEYMTETMDDyKSkMJye13jY6AAAALHRSTlMAavLy8vJi9PLy4vru2L6UhGs1JRAI5VEb8vLo3qyqfHpIRUA/Eg/y8vJTHBug3AoAAAhOSURBVGjevZqF39JAGIDt7u5uD7fBSoeIM1GwwADBDmzB7u7u7u7u7u7Ov8WLsaAUnD4/f+x27rvnu727947vlkOlTL6qRYvkzxWjQaU8eirVz/WH5C9StFq+ejniKVsiPzDQu8ma7hpNmnQAmZC/RFlj+6UKgTg2NTHSBmRG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
// @icon64          data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAMAAACdt4HsAAACNFBMVEUAAAD////////4rKyYmJj////3pqb7zMz4trb////////////////////////819f5wMD////////////83d36xMT5urqOjo7/////////////+Pj+8vL96+v95+f95eX84+O6urr4r6+qqqr3qKj////////////////sKCgAAADsJCTsKSnrICDpCgrrHh7qERHsIiLpBQX+8PDrGxvrGBjqDg7pBwfrFRURERH/+fn82Nh7e3vtLS3809PwXFztLi7pAADs7e381tb7zs7uMzPqDAz96urvR0f82trtMDD+8/PwUVHwS0v95+f3o6P4qan3oKDyamr/+/v+7u7zbW3xV1fvQ0M5OTnqCgrmAADn5+f7yMj6wcH6vLz2mZn2kZHzdHRhYWFaWlruPj7uOzvuODguLi7+9/f/9fXx8fH95ub95eX84OD7y8vExMT7w8O6urr3nJz0gIDwVFT/NDQJCwv94uL83t7V1dX70NC+vr62trb4rq6ZmZn2lZWKiopqampoaGjyZGTxXFxPT0//QUHuQEDtFhbe3t73trb1s7Nzi4v1iYmIiIj0g4N5eXmjc3PzcnJCQkL/OTkpKSkdHR39///t///u7u7q6urf39/IyMj6vr7NpaWkpKSQkJCBgYHzd3ewcnJubm7xZWWiZGTxYWFXV1cAGRkYGBjd+fn19fXh4eGsrKzQl5fHlpatgoKkfHy0dnaqa2tiYmJdXV3/RkYjPDwXMzP/MDD+KSmHIHNsAAAAKHRSTlMAv/Dw8Ljw8PDj05JnMQbw8NxdR/Dw8PC5Q0Lw8PDw8PDw8PDw3V5JgcnJaAAABWxJREFUWMOl14dX00AcB3D33nvvcZdc1tE0EUQboQXBKqVIbQUBBVRERMC999577733+uf8XdKkDa/aoN/3SJMr9+nl7jKum5khg3r372Fl+theVsbO7PGX9O89aEg3JyOHIyeXODsv0d8zfKRdf0R68REHWIuyZYRVfzD6VwANNoEBrrIdu3ft2rXpIAArsgMDWP0JKEMeA3AAZc94AAaiDLkCwF4PwEAAemcoX8lBdqADzw80odtrjmw+sWa1meebkDvjAOieAdgM9eeha7BtQis47sRuLpn7yJ3ufwD2m334eh4oizjuCLpnA/c8Amvgfw+iRQx4wHG30Y0dtw5Aya0dTR6BtawPGXBl5dXkcJ7luLPwkRVI9eEmBlw6y3ZY5nPcfM8A68OtNxhw9SqchXfA3YcMgHhvgbsPvzjAg64Da9mIO8ClLgMrt0K1XRaw4gq3tckj4O7DmxZwAi6r3V0F9ls3A2si7eW4896BVB9+tYE3cBregVQf7k8CUfSS4256BlLzcHMSaGLteds1wLx2VyaBRawTDsLBeegLj8BpqP8dQa6/4F5cR6+2cj+umaWnswLrSis2bNx+9+OHC+9bq6vvnHr09NGpVXc+Pf18srr63YULdxcUbN/YXJSzLjNwanm4viEYIPjyt6NHt6i6qh/fcnnLcdnc6vqvo0d/SgomgWBjQ/GhSG5nYHGYUllXVZ9PkgRBYeHTYhYIgiRJPlXVZc0IrnIDO30GT7DnEBynZelAEdas6t4JXWxJAx4aAcUv2/HrhKR+S/bL9rFLoMUpoIhX+WC42E74GI/t8KQ4bB+7w8dbHWBPHPuXoFRadAUnowZLEcqTBJyhCeccoEbD/nAasCAdgAHbngnAYrkD1Go43pEGNKcDOQgVZAYOOUC7htX6SKT2JFSuaKtZdk7iPQChSge4qOF8RdMSMdZ8w9BkNnEwUSAWIEi6jmEkoEyX1eSMkcMOsFy02rQQgDxBwsQH883a6gzIo7S+URRgMDW1IRb0+wkj9FjUBp7EXYAi7NlZWB2Qy3YWVmEegNZAWXR9rczztLwwF1WcjGkmUL/OBg6HXIDgK4KdErqNbSUAlkYR5KFGLyIz0ZgIgtqYYwOV/k7AAoRyAmIhQrn5Qo4zuEYJgmyAvwJZYf1bYQNLsgDrKw/DbNhmtMP3dWIZsmr4Soq8AgsSWjNc8XQZjLKUYHN2Of0rILkBaDG/AQANfnsjb3QwQCNdBJaaLQBATMSyA74/A6Vlbav+B7Bzkf4zUMqSWy66gErvwIbG/CDPJ6+zitRM9AxsUzUfD4J7Jh4SPQPNxKhcX7qOnYLeUGoD5RmAihJa5Uwkv9KcmgeVbD5SAI7l2kBdJ0AqgBaEEgU2kJegRQDQCPShkmBAOXXdD9q1TkAe7OwrQzYQPVOL2LVQB9tIfRVsYzLG/g4HqHUDvGY9txzASpXB24/VVRoMRPxZ+l2ZhZYjuPIkiYTCCHJmO2wCEiurQpCOkNhhPVN3KjpJ3ZV7w3NBtAa2uGZfzTk2RuKzlpYnRl2kbR/h97VF6uT2wqpDcUK0+pqWgtYzkpzPngvt1oJjIMwOxceAfIlSKhKCCQmpqohlSjVMNEplicIxgchUlWTqg/qYF+FEByYXXcsNknwSWp/sjpzccx8TrAi8tacdi8KiK7nsWyqFAO1KiEqrYdnnLDxbZQq658C5GG1s4Zla+hY2GJpuv57wfwh7S5EkeFyIBr8HKs1xLb4jhxtK8jEvwPc6e0lgCZkxd6FI11WfBF0QaFxSCzNz9lyrdmr5P3Hy1FFDh/btO3rYmH79ZvSEzOrD0pOlX78xw4aN7tt36KhpUyalLf9/A5nj/LZRV7kLAAAAAElFTkSuQmCC
// @license         GPL-3.0-only
// @homepageURL     https://7kt.se/
// @downloadURL	    https://7kt.se/install/7ktTube.user.js
// @updateURL	    https://7kt.se/install/7ktTube.user.js
// @supportURL      https://discord.7kt.se/
// @contributionURL https://www.paypal.com/donate/?hosted_button_id=2EJR4DLTR4Y7Q
// BEGIN MODULES
// @require         https://7kt.se/resources/modules/424/tempcssfix.js
// @require         https://7kt.se/resources/modules/424/flags.js
// @require         https://7kt.se/resources/modules/424/home.js
// @require         https://7kt.se/resources/modules/424/settings.js
// @require         https://7kt.se/resources/modules/424/styles.js
// @require         https://7kt.se/resources/modules/424/watch.js
// @require         https://greasyfork.org/scripts/28536-gm-config/code/GM_config.js?version=184529
// END MODULES
// @match       *://*.youtube.com/*
// @grant       GM_addStyle
// @grant       GM_getValue
// @grant       GM.getValue
// @grant       GM.setValue
// @grant       GM_setValue
// @grant       GM_registerMenuCommand
// @grant       unsafeWindow
// @run-at      document-start

// ==/UserScript==
/*jshint esversion: 6 */
// fix GM_addStyle

if (typeof GM_addStyle !== "function") {
    function GM_addStyle(css) {
        let style = document.createElement('style');
        style.type = 'text/css';
        style.appendChild(document.createTextNode(css));
        const head = document.documentElement ?? document.getElementsByTagName("head")[0];
        head.appendChild(style);
    }
}

function removePlayerElements() {
    document.querySelectorAll("#masthead-ad,#root").forEach(e => e.remove());
    document.querySelector("ytd-miniplayer")?.remove();
    document.querySelector("ytd-miniplayer-ui")?.remove();
    document.querySelector(".ytp-miniplayer-button")?.remove();
    if (window.location.pathname != "/watch") document.querySelector("#movie_player video")?.remove();
}

function gen_aspect_fix() {
    "use strict";
    var vidfix = {
        inject: function(is_user_script) {
            var modules;
            var vidfix_api;
            var user_settings;
            var default_language;
            var send_settings_to_page;
            var receive_settings_from_page;
            modules = [];
            vidfix_api = {
                initializeBypasses: function() {
                    var ytd_watch;
                    var sizeBypass;
                    if (ytd_watch = document.querySelector("ytd-watch, ytd-watch-flexy")) {
                        sizeBypass = function() {
                            var width;
                            var height;
                            var movie_player;
                            if (!ytd_watch.theater && !document.querySelector(".iri-full-browser") && (movie_player = document.querySelector("#movie_player"))) {
                                width = movie_player.offsetWidth;
                                height = Math.round(movie_player.offsetWidth / (16 / 9));
                                if (ytd_watch.updateStyles) {
                                    ytd_watch.updateStyles({
                                        "--ytd-watch-flexy-width-ratio": 1,
                                        "--ytd-watch-flexy-height-ratio": 0.5625
                                    });
                                    ytd_watch.updateStyles({
                                        "--ytd-watch-width-ratio": 1,
                                        "--ytd-watch-height-ratio": 0.5625
                                    });
                                }
                            }
                            else {
                                width = window.NaN;
                                height = window.NaN;
                            }
                            return {
                                width: width,
                                height: height
                            };
                        };
                        if (ytd_watch.calculateCurrentPlayerSize_) {
                            if (!ytd_watch.calculateCurrentPlayerSize_.bypassed) {
                                ytd_watch.calculateCurrentPlayerSize_ = sizeBypass;
                                ytd_watch.calculateCurrentPlayerSize_.bypassed = true;
                            }
                            if (!ytd_watch.calculateNormalPlayerSize_.bypassed) {
                                ytd_watch.calculateNormalPlayerSize_ = sizeBypass;
                                ytd_watch.calculateNormalPlayerSize_.bypassed = true;
                            }
                        }
                    }
                },
                initializeSettings: function(new_settings) {
                    var i;
                    var j;
                    var option;
                    var options;
                    var loaded_settings;
                    var vidfix_settings;
                    if (vidfix_settings = document.getElementById("vidfix-settings")) {
                        loaded_settings = JSON.parse(vidfix_settings.textContent || "null");
                        receive_settings_from_page = vidfix_settings.getAttribute("settings-beacon-from");
                        send_settings_to_page = vidfix_settings.getAttribute("settings-beacon-to");
                        vidfix_settings.remove();
                    }
                    user_settings = new_settings || loaded_settings || user_settings || {};
                    for (i = 0; i < modules.length; i++) {
                        for (options in modules[i].options) {
                            if (modules[i].options.hasOwnProperty(options)) {
                                option = modules[i].options[options];
                                if (!(option.id in user_settings) && "value" in option) {
                                    user_settings[option.id] = option.value;
                                }
                            }
                        }
                    }
                },
                initializeModulesUpdate: function() {
                    var i;
                    for (i = 0; i < modules.length; i++) {
                        if (modules[i].onSettingsUpdated) {
                            modules[i].onSettingsUpdated();
                        }
                    }
                },
                initializeModules: function() {
                    var i;
                    for (i = 0; i < modules.length; i++) {
                        if (modules[i].ini) {
                            modules[i].ini();
                        }
                    }
                },
                initializeOption: function() {
                    var key;
                    if (this.started) {
                        return true;
                    }
                    this.started = true;
                    for (key in this.options) {
                        if (this.options.hasOwnProperty(key)) {
                            if (!(key in user_settings) && this.options[key].value) {
                                user_settings[key] = this.options[key].value;
                            }
                        }
                    }
                    return false;
                },
                initializeBroadcast: function(event) {
                    if (event.data) {
                        if (event.data.type === "settings") {
                            if (event.data.payload) {
                                if (event.data.payload.broadcast_id === this.broadcast_channel.name) {
                                    this.initializeSettings(event.data.payload);
                                    this.initializeModulesUpdate();
                                }
                            }
                        }
                    }
                },
                ini: function() {
                    this.initializeSettings();
                    this.broadcast_channel = new BroadcastChannel(user_settings.broadcast_id);
                    this.broadcast_channel.addEventListener("message", this.initializeBroadcast.bind(this));
                    document.documentElement.addEventListener("load", this.initializeSettingsButton, true);
                    document.documentElement.addEventListener("load", this.initializeBypasses, true);
                    if (this.isSettingsPage) {
                        this.initializeModules();
                    }
                }
            };
            vidfix_api.ini();
        },
        isAllowedPage: function() {
            var current_page;
            if (current_page = window.location.pathname.match(/\/[a-z-]+/)) {
                current_page = current_page[0];
            }
            else {
                current_page = window.location.pathname;
            }
            return ["/tv", "/embed", "/live_chat", "/account", "/account_notifications", "/create_channel", "/dashboard", "/upload", "/webcam"].indexOf(current_page) < 0;
        },
        generateUUID: function() {
            return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11)
                .replace(/[018]/g, function(point) {
                return (point ^ window.crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> point / 4)
                    .toString(16);
            });
        },
        saveSettings: function() {
            if (this.is_user_script) {
                this.GM.setValue(this.id, JSON.stringify(this.user_settings));
            }
            else {
                chrome.storage.local.set({
                    vidfixSettings: this.user_settings
                });
            }
        },
        updateSettingsOnOpenWindows: function() {
            this.broadcast_channel.postMessage({
                type: "settings",
                payload: this.user_settings
            });
        },
        settingsUpdatedFromOtherWindow: function(event) {
            if (event.data && event.data.broadcast_id === this.broadcast_channel.name) {
                this.user_settings = event.data;
                this.saveSettings();
            }
        },
        contentScriptMessages: function(custom_event) {
            var updated_settings;
            if ((updated_settings = custom_event.detail.settings) !== undefined) {
                this.saveSettings();
            }
        },
        initializeScript: function(event) {
            var holder;
            this.user_settings = event[this.id] || event;
            if (!this.user_settings.broadcast_id) {
                this.user_settings.broadcast_id = this.generateUUID();
                this.saveSettings();
            }
            this.broadcast_channel = new BroadcastChannel(this.user_settings.broadcast_id);
            this.broadcast_channel.addEventListener("message", this.settingsUpdatedFromOtherWindow.bind(this));
            event = JSON.stringify(this.user_settings);
            holder = document.createElement("vidfix-settings");
            holder.id = "vidfix-settings";
            holder.textContent = event;
            holder.setAttribute("style", "display: none");
            holder.setAttribute("settings-beacon-from", this.receive_settings_from_page);
            holder.setAttribute("settings-beacon-to", this.send_settings_to_page);
            document.documentElement.appendChild(holder);
            holder = document.createElement("script");
            holder.textContent = "(" + this.inject + "(" + this.is_user_script.toString() + "))";
            document.documentElement.appendChild(holder);
            holder.remove();
            this.inject = null;
            delete this.inject;
        },
        main: function(event) {
            var now;
            var context;
            now = Date.now();
            this.receive_settings_from_page = now + "-" + this.generateUUID();
            this.send_settings_to_page = now + 1 + "-" + this.generateUUID();
            window.addEventListener(this.receive_settings_from_page, this.contentScriptMessages.bind(this), false);
            if (!event) {
                if (this.is_user_script) {
                    context = this;
                    // javascript promises are horrible
                    this.GM.getValue(this.id, "{}")
                        .then(function(value) {
                        event = JSON.parse(value);
                        context.initializeScript(event);
                    });
                }
            }
            else {
                this.initializeScript(event);
            }
        },
        ini: function() {
            if (this.isAllowedPage()) {
                this.is_settings_page = window.location.pathname === "/vidfix-settings";
                this.id = "vidfixSettings";
                if (typeof GM === "object" || typeof GM_info === "object") {
                    this.is_user_script = true;
                    // GreaseMonkey 4 polly fill
                    // https://arantius.com/misc/greasemonkey/imports/greasemonkey4-polyfill.js
                    if (typeof GM === "undefined") {
                        this.GM = {
                            setValue: GM_setValue,
                            info: GM_info,
                            getValue: function() {
                                return new Promise((resolve, reject) => {
                                    try {
                                        resolve(GM_getValue.apply(this, arguments));
                                    }
                                    catch (e) {
                                        reject(e);
                                    }
                                });
                            }
                        };
                    }
                    else {
                        this.GM = GM;
                    }
                    this.main();
                }
                else {
                    this.is_user_script = false;
                    chrome.storage.local.get(this.id, this.main.bind(this));
                }
            }
        }
    };

    vidfix.ini();
}

function waitForElement(selector) {
    return new Promise(resolve => {
        const query = document.querySelector(selector);
        if (query) return resolve(query);
        const observer = new MutationObserver(mutations => {
            const query = document.querySelector(selector);
            if (query) {
                resolve(query);
                observer.disconnect();
            }
        });
        observer.observe(document, {
            childList: true,
            subtree: true
        });
    });
}
function gen_history() {
    /*
     - Grey out watched video thumbnails info:
     - Use ALT+LeftClick or ALT+RightClick on a video list item to manually toggle the watched marker. The mouse button is defined in the script and can be changed.
     - For restoring/merging history, source file can also be a YouTube's history data JSON (downloadable from https://support.google.com/accounts/answer/3024190?hl=en). Or a list of YouTube video URLs (using current time as timestamps).
   */
    //=== config start ===
    var maxWatchedVideoAge   = 5 * 365; //number of days. set to zero to disable (not recommended)
    var contentLoadMarkDelay = 600;     //number of milliseconds to wait before marking video items on content load phase (increase if slow network/browser)
    var markerMouseButtons   = [0, 1];  //one or more mouse buttons to use for manual marker toggle. 0=left, 1=right, 2=middle. e.g.:
    //if `[0]`, only left button is used, which is ALT+LeftClick.
    //if `[1]`, only right button is used, which is ALT+RightClick.
    //if `[0,1]`, any left or right button can be used, which is: ALT+LeftClick or ALT+RightClick.
    //=== config end ===

    var watchedVideos, ageMultiplier = 24 * 60 * 60 * 1000, xu = /\/watch(?:\?|.*?&)v=([^&]+)|\/shorts\/([^\/\?]+)/,
    querySelector = Element.prototype.querySelector, querySelectorAll = Element.prototype.querySelectorAll;
    function getVideoId(url) {
        var vid = url.match(xu);
        if (vid) vid = vid[1] || vid[2];
        return vid;
    }

    function watched(vid) {
        return !!watchedVideos.entries[vid];
    }

    function processVideoItems(selector) {
        var items = document.querySelectorAll(selector), i, link;
        for (i = items.length-1; i >= 0; i--) {
            if (link = querySelector.call(items[i], "A")) {
                if (watched(getVideoId(link.href))) {
                    items[i].classList.add("watched");
                } else items[i].classList.remove("watched");
            }
        }
    }

  function processAllVideoItems() {
    //home page
    processVideoItems(`.yt-uix-shelfslider-list>.yt-shelf-grid-item`);
    processVideoItems(`#contents.ytd-rich-grid-renderer>ytd-rich-item-renderer, #contents.ytd-rich-shelf-renderer ytd-rich-item-renderer.ytd-rich-shelf-renderer, #contents.ytd-rich-grid-renderer>ytd-rich-grid-row ytd-rich-grid-media`);
    //subscriptions page
    processVideoItems(`.multirow-shelf>.shelf-content>.yt-shelf-grid-item`);
    //history:watch page
    processVideoItems(`ytd-section-list-renderer[page-subtype="history"] .ytd-item-section-renderer>ytd-video-renderer`);
    //channel/user home page
    processVideoItems(`#contents>.ytd-item-section-renderer>.ytd-newspaper-renderer, #items>.yt-horizontal-list-renderer`); //old
    processVideoItems(`#contents>.ytd-channel-featured-content-renderer, #contents>.ytd-shelf-renderer>#grid-container>.ytd-expanded-shelf-contents-renderer`); //new
    //channel/user video page
    processVideoItems(`.yt-uix-slider-list>.featured-content-item, .channels-browse-content-grid>.channels-content-item, #items>.ytd-grid-renderer`);
    //channel/user shorts page
    processVideoItems(`ytd-rich-item-renderer ytd-rich-grid-slim-media`);
    //channel/user playlist page
    processVideoItems(`.expanded-shelf>.expanded-shelf-content-list>.expanded-shelf-content-item-wrapper, .ytd-playlist-video-renderer`);
    //channel/user playlist item page
    processVideoItems(`.pl-video-list .pl-video-table .pl-video, ytd-playlist-panel-video-renderer`);
    //channel/user search page
    if (/^\/(?:(?:c|channel|user)\/)?.*?\/search/.test(location.pathname)) {
      processVideoItems(`.ytd-browse #contents>.ytd-item-section-renderer`); //new
    }
    //search page
    processVideoItems(`#results>.section-list .item-section>li, #browse-items-primary>.browse-list-item-container`); //old
    processVideoItems(`.ytd-search #contents>ytd-video-renderer, .ytd-search #contents>ytd-playlist-renderer, .ytd-search #items>ytd-video-renderer`); //new
    //video page
    processVideoItems(`.watch-sidebar-body>.video-list>.video-list-item, .playlist-videos-container>.playlist-videos-list>li`); //old
    processVideoItems(`.ytd-compact-video-renderer, .ytd-compact-radio-renderer`); //new
  }

    function addHistory(vid, time, noSave, i) {
        if (!watchedVideos.entries[vid]) {
            watchedVideos.index.push(vid);
        } else {
            i = watchedVideos.index.indexOf(vid);
            if (i >= 0) watchedVideos.index.push(watchedVideos.index.splice(i, 1)[0])
        }
        watchedVideos.entries[vid] = time;
        if (!noSave) GM_setValue("watchedVideos", JSON.stringify(watchedVideos));
    }

    function delHistory(index, noSave) {
        delete watchedVideos.entries[watchedVideos.index[index]];
        watchedVideos.index.splice(index, 1);
        if (!noSave) GM_setValue("watchedVideos", JSON.stringify(watchedVideos));
    }

    var dc, ut;
    function parseData(s, a, i, j, z) {
        try {
            dc = false;
            s = JSON.parse(s);
            //convert to new format if old format.
            //old: [{id:<strVID>, timestamp:<numDate>}, ...]
            //new: {entries:{<stdVID>:<numDate>, ...}, index:[<strVID>, ...]}
            if (Array.isArray(s) && (!s.length || (("object" === typeof s[0]) && s[0].id && s[0].timestamp))) {
                a = s;
                s = {entries: {}, index: []};
                a.forEach(o => {
                    s.entries[o.id] = o.timestamp;
                    s.index.push(o.id);
                });
            } else if (("object" !== typeof s) || ("object" !== typeof s.entries) || !Array.isArray(s.index)) return null;
            //reconstruct index if broken
            if (s.index.length !== (a = Object.keys(s.entries)).length) {
                s.index = a.map(k => [k, s.entries[k]]).sort((x, y) => x[1] - y[1]).map(v => v[0]);
                dc = true;
            }
            return s;
        } catch(z) {
            return null;
        }
    }

    function parseYouTubeData(s, a) {
        try {
            s = JSON.parse(s);
            //convert to native format if YouTube format.
            //old: [{titleUrl:<strUrl>, time:<strIsoDate>}, ...] (excludes irrelevant properties)
            //new: {entries:{<stdVID>:<numDate>, ...}, index:[<strVID>, ...]}
            if (Array.isArray(s) && (!s.length || (("object" === typeof s[0]) && s[0].titleUrl && s[0].time))) {
                a = s;
                s = {entries: {}, index: []};
                a.forEach((o, m, t) => {
                    if (o.titleUrl && (m = o.titleUrl.match(xu))) {
                        if (isNaN(t = (new Date(o.time)).getTime())) t = (new Date()).getTime();
                        s.entries[m[1] || m[2]] = t;
                        s.index.push(m[1] || m[2]);
                    }
                });
                s.index.reverse();
                return s;
            } else return null;
        } catch(a) {
            return null;
        }
    }

    function mergeData(o, a) {
        o.index.forEach(i => {
            if (watchedVideos.entries[i]) {
                if (watchedVideos.entries[i] < o.entries[i]) watchedVideos.entries[i] = o.entries[i];
            } else watchedVideos.entries[i] = o.entries[i];
        });
        a = Object.keys(watchedVideos.entries);
        watchedVideos.index = a.map(k => [k, watchedVideos.entries[k]]).sort((x, y) => x[1] - y[1]).map(v => v[0]);
    }

    function getHistory(a, b) {
        a = GM_getValue("watchedVideos");
        if (a === undefined) {
            a = '{"entries": {}, "index": []}';
        } else if ("object" === typeof a) a = JSON.stringify(a);
        if (b = parseData(a)) {
            watchedVideos = b;
            if (dc) b = JSON.stringify(b);
        } else b = JSON.stringify(watchedVideos = {entries: {}, index: []});
        GM_setValue("watchedVideos", b);
    }

    function doProcessPage() {
        //get list of watched videos
        getHistory();

        //remove old watched video history
        var now = (new Date()).valueOf(), changed, vid;
        if (maxWatchedVideoAge > 0) {
            while (watchedVideos.index.length) {
                if (((now - watchedVideos.entries[watchedVideos.index[0]]) / ageMultiplier) > maxWatchedVideoAge) {
                    delHistory(0, false);
                    changed = true;
                } else break;
            }
            if (changed) GM_setValue("watchedVideos", JSON.stringify(watchedVideos));
        }

        //check and remember current video
        if ((vid = getVideoId(location.href)) && !watched(vid)) addHistory(vid, now);

        //mark watched videos
        processAllVideoItems();
    }
    function processPage() {
        setTimeout(doProcessPage, Math.floor(contentLoadMarkDelay / 2));
    }

    function delayedProcessPage() {
        setTimeout(doProcessPage, contentLoadMarkDelay);
    }

  function toggleMarker(ele, i) {
    if (ele) {
      if (ele.href) {
        i = getVideoId(ele.href);
      } else {
        while (ele) {
          while (ele && (!ele.__data || !ele.__data.data || !ele.__data.data.videoId)) ele = ele.__dataHost || ele.parentNode;
          if (ele) {
            i = ele.__data.data.videoId;
            break
          }
        }
      }
      if (i) {
        if ((ele = watchedVideos.index.indexOf(i)) >= 0) {
          delHistory(ele);
        } else addHistory(i, (new Date()).valueOf());
        processAllVideoItems();
      }
    }
  }

    var rxListUrl = /\/\w+_ajax\?|\/results\?search_query|\/v1\/(browse|next|search)\?/;
    var xhropen = XMLHttpRequest.prototype.open, xhrsend = XMLHttpRequest.prototype.send;
    XMLHttpRequest.prototype.open = function(method, url) {
        this.url_mwyv = url;
        return xhropen.apply(this, arguments);
    };
    XMLHttpRequest.prototype.send = function(method, url) {
        if (rxListUrl.test(this.url_mwyv) && !this.listened_mwyv) {
            this.listened_mwyv = 1;
            this.addEventListener("load", delayedProcessPage);
        }
        return xhrsend.apply(this, arguments);
    };

    var fetch_ = unsafeWindow.fetch;
    unsafeWindow.fetch = function(opt) {
        let url = opt.url || opt;
        if (rxListUrl.test(opt.url || opt)) {
            return fetch_.apply(this, arguments).finally(delayedProcessPage);
        } else return fetch_.apply(this, arguments);
    };

    addEventListener("DOMContentLoaded", sty => {
        sty = document.createElement("STYLE");
        sty.innerHTML = `

`;
        document.head.appendChild(sty);
        var nde = Node.prototype.dispatchEvent;
        Node.prototype.dispatchEvent = function(ev) {
            if (ev.type === "yt-service-request-completed") {
                clearTimeout(ut);
                ut = setTimeout(doProcessPage, contentLoadMarkDelay / 2)
            }
            return nde.apply(this, arguments)
        };
    });

    var lastFocusState = document.hasFocus();
    addEventListener("blur", () => {
        lastFocusState = false;
    });
    addEventListener("focus", () => {
        if (!lastFocusState) processPage();
        lastFocusState = true;
    });
    addEventListener("click", (ev) => {
    if ((markerMouseButtons.indexOf(ev.button) >= 0) && ev.altKey) {
      ev.stopImmediatePropagation();
      ev.stopPropagation();
      ev.preventDefault();
      toggleMarker(ev.target);
    }
  }, true);

    if (markerMouseButtons.indexOf(1) >= 0) {
        addEventListener("contextmenu", (ev) => {
            if (ev.altKey) toggleMarker(ev.target);
        });
    }
    if (window["body-container"]) { //old
        addEventListener("spfdone", processPage);
        processPage();
    } else { //new
        var t = 0;
        function pl() {
            clearTimeout(t);
            t = setTimeout(processPage, 300);
        }
        (function init(vm) {
            if (vm = document.getElementById("visibility-monitor")) {
                vm.addEventListener("viewport-load", pl);
            } else setTimeout(init, 100);
        })();
        (function init2(mh) {
            if (mh = document.getElementById("masthead")) {
                mh.addEventListener("yt-rendererstamper-finished", pl);
            } else setTimeout(init2, 100);
        })();
        addEventListener("load", delayedProcessPage);
        addEventListener("spfprocess", delayedProcessPage);
    }

    GM_registerMenuCommand("Display History Statistics", () => {
        function sum(r, v) {
            return r + v;
        }
        function avg(arr) {
            return arr && arr.length ? Math.round(arr.reduce(sum, 0) / arr.length) : "(n/a)";
        }
        var pd, pm, py, ld = [], lm = [], ly = [];
        getHistory();
        Object.keys(watchedVideos.entries).forEach((k, t) => {
            t = new Date(watchedVideos.entries[k]);
            if (!pd || (pd !== t.getDate())) {
                ld.push(1);
                pd = t.getDate();
            } else ld[ld.length - 1]++;
            if (!pm || (pm !== (t.getMonth() + 1))) {
                lm.push(1);
                pm = t.getMonth() + 1;
            } else lm[lm.length - 1]++;
            if (!py || (py !== t.getFullYear())) {
                ly.push(1);
                py = t.getFullYear();
            } else ly[ly.length - 1]++;
        });
        if (watchedVideos.index.length) {
            pd = (new Date(watchedVideos.entries[watchedVideos.index[0]])).toLocaleString();
            pm = (new Date(watchedVideos.entries[watchedVideos.index[watchedVideos.index.length - 1]])).toLocaleString();
        } else {
            pd = "(n/a)";
            pm = "(n/a)";
        }
        alert(`\
Number of entries: ${watchedVideos.index.length}
Oldest entry: ${pd}
Newest entry: ${pm}

Average viewed videos per day: ${avg(ld)}
Average viewed videos per month: ${avg(lm)}
Average viewed videos per year: ${avg(ly)}

History data size: ${JSON.stringify(watchedVideos).length} bytes\
`);
  });

    GM_registerMenuCommand("Backup History Data", (a, b) => {
        document.body.appendChild(a = document.createElement("A")).href = URL.createObjectURL(new Blob([JSON.stringify(watchedVideos)], {type: "application/json"}));
        a.download = `MarkWatchedYouTubeVideos_${(new Date()).toISOString()}.json`;
        a.click();
        a.remove();
        URL.revokeObjectURL(a.href);
    });

    GM_registerMenuCommand("Restore History Data", (a, b) => {
        function askRestore(o) {
            if (confirm(`Selected history data file contains ${o.index.length} entries.\n\nRestore from this data?`)) {
                if (mwyvrhm_ujs.checked) {
                    mergeData(o);
                } else watchedVideos = o;
                GM_setValue("watchedVideos", JSON.stringify(watchedVideos));
                a.remove();
                doProcessPage();
            }
        }
        if (window.mwyvrh_ujs) return;
        (a = document.createElement("DIV")).id = "mwyvrh_ujs";
        a.innerHTML = `<style>
       #mwyvrh_ujs {display:flex;position:fixed;z-index:99999;left:0;top:0;right:0;bottom:0;margin:0;border:none;padding:0;background:rgb(0,0,0,0.5);color:#000;font-family:sans-serif;font-size:12pt;line-height:12pt;font-weight:normal;cursor:pointer}
       #mwyvrhb_ujs {margin:auto;border:.3rem solid #007;border-radius:.3rem;padding:.5rem .5em;background-color:#fff;cursor:auto}
       #mwyvrht_ujs {margin-bottom:1rem;font-size:14pt;line-height:14pt;font-weight:bold}
       #mwyvrhmc_ujs {margin:.5em 0 1em 0;text-align:center}
       #mwyvrhi_ujs {display:block;margin:1rem auto .5rem auto;overflow:hidden}
       </style>
<div id="mwyvrhb_ujs">
  <div id="mwyvrht_ujs">Mark Watched YouTube Videos</div>
  Please select a file to restore history data from.
  <div id="mwyvrhmc_ujs"><label><input id="mwyvrhm_ujs" type="checkbox" checked /> Merge history data instead of replace.</label></div>
  <input id="mwyvrhi_ujs" type="file" multiple />
</div>`;
        a.onclick = e => {
            (e.target === a) && a.remove();
        };
        (b = a.querySelector("#mwyvrhi_ujs")).onchange = r => {
            r = new FileReader();
            r.onload = (o, t) => {
                if (o = parseData(r = r.result)) { //parse as native format
                    if (o.index.length) {
                        askRestore(o);
                    } else alert("File doesn't contain any history entry.");
                } else if (o = parseYouTubeData(r)) { //parse as YouTube format
                    if (o.index.length) {
                        askRestore(o);
                    } else alert("File doesn't contain any history entry.");
                } else { //parse as URL list
                    o = {entries: {}, index: []};
                    t = (new Date()).getTime();
                    r = r.replace(/\r/g, "").split("\n");
                    while (r.length && !r[0].trim()) r.shift();
                    if (r.length && xu.test(r[0])) {
                        r.forEach(s => {
                            if (s = s.match(xu)) {
                                o.entries[s[1] || s[2]] = t;
                                o.index.push(s[1] || s[2]);
                            }
                        });
                        if (o.index.length) {
                            askRestore(o);
                        } else alert("File doesn't contain any history entry.");
                    } else alert("Invalid history data file.");
                }
            };
            r.readAsText(b.files[0]);
        };
        document.documentElement.appendChild(a);
        b.click();
    });
}

function counterstuff() {
    function replaceCountersText(elm) {
        const renderer = elm.parentNode.renderer;
        const count = renderer?.data?.viewCountText?.simpleText ?? renderer?.data?.content?.videoRenderer?.viewCountText?.simpleText;
        if (count && elm.textContent != count)
            elm.textContent = count;
    }

    const counterObserver = new MutationObserver(mutations => mutations.filter(m => m.type == "characterData").forEach(m => replaceCountersText(m.target)));
    // this observer disables the like count updating while watching a live stream because it messes with a bunch of things and we can't get full like count from it either
    const likeObserver = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            while (mutation.target.childNodes.length > 1) {
                mutation.target.removeChild(mutation.target.lastChild);
            }
        });
    });

    function replaceCountersEach(elm) {
        elm.setAttribute("patched7kt", "");
        const counters = elm.querySelectorAll("#metadata-line span");
        if (counters.length != 2)
            return;
        counters[0].renderer = elm;
        replaceCountersText(counters[0].firstChild);
        counterObserver.observe(counters[0], { subtree: true, characterData: true });
    }

    function replaceCommentCounter(elm) {
        elm.setAttribute("patched7kt", "");
        const voteCount = elm.querySelector("#vote-count-middle");
        if (!isNaN(voteCount.innerText))
            return;
        const fullCount = parseInt(elm.querySelector("#like-button button").getAttribute("aria-label").match(/\d/g).join(""));
        voteCount.innerText = fullCount;
    }

    setInterval (function() {
        document.querySelectorAll('ytd-compact-video-renderer:not([patched7kt])').forEach(replaceCountersEach);
        document.querySelectorAll('ytd-grid-video-renderer:not([patched7kt])').forEach(replaceCountersEach);
        document.querySelectorAll('ytd-rich-item-renderer:not([patched7kt])').forEach(replaceCountersEach);
        document.querySelectorAll('ytd-video-renderer:not([patched7kt])').forEach(replaceCountersEach);
        document.querySelectorAll('ytd-comment-renderer:not([patched7kt])').forEach(replaceCommentCounter);
    }, 1000);

    waitForElement("#info #segmented-like-button #text").then(elm => likeObserver.observe(elm, { childList: true, subtree: true }));
}

waitForElement('ytd-compact-link-renderer').then(function(elm) {
    const link = document.querySelector('#container yt-multi-page-menu-section-renderer:nth-child(2) ytd-compact-link-renderer:nth-child(4)');
    if (link !== null)
        document.querySelector('#container yt-multi-page-menu-section-renderer:nth-child(2) ytd-compact-link-renderer:nth-child(4)').style.left = document.querySelector('[menu-style="multi-page-menu-style-type-system"] #container yt-multi-page-menu-section-renderer:first-child ytd-compact-link-renderer:nth-child(3) a').offsetWidth+"px";
});

function restoreDropdown(iconLabel, firstChild, dropdownChildren) {
    const iconLabelSel = document.querySelector(iconLabel);
    if (!window.location.search.includes("sort")) // channel sort dropdown fix
        iconLabelSel.innerHTML = document.querySelector(firstChild)?.innerHTML;

    for (const x of document.querySelectorAll(dropdownChildren)) {
        x.addEventListener("click", function() {
            iconLabelSel.innerHTML = this.innerHTML;
        }, false);
    }
}

async function setupUpdateDependentElements(e) {
    if (e.detail.pageType == "watch") {
        waitForElement('#top-row.ytd-video-secondary-info-renderer').then(setupSecondaryInfoRenderer);
        waitForElement('#info-strings.ytd-video-primary-info-renderer yt-formatted-string').then((elm) => setUploadedText(elm));

        // classic description
        var description;
        waitForElement('tp-yt-paper-button[id="more"]').then((elm) => elm.addEventListener("click", () => description.removeAttribute("collapsed")));
        waitForElement('ytd-expander.ytd-video-secondary-info-renderer').then((elm) => { description = elm });
        waitForElement('ytd-engagement-panel-section-list-renderer[target-id="engagement-panel-structured-description"]').then((elm) => elm?.remove());

        waitForElement("ytd-menu-popup-renderer tp-yt-paper-listbox").then(function(elm) {
            const saveBtn = [...elm.children].find(item => item.__data.icon == "yt-icons:playlist_add");
            saveBtn.classList.add("addto-btn");
        });
    }

    if (/home|trending|subscriptions/.test(e.detail.pageType)) {
        waitForElement("#endpoint.ytd-guide-entry-renderer[href^='/feed/trending'] yt-formatted-string").then(createNavBar);
        document.querySelector("[hidden] .ytcp-main-appbar")?.remove();
    }

    waitForElement("ytd-comments-header-renderer yt-dropdown-menu:last-of-type").then(function() {
        restoreDropdown("ytd-comments-header-renderer #icon-label.yt-dropdown-menu",
                        "ytd-comments-header-renderer a.yt-dropdown-menu:first-child > tp-yt-paper-item:first-child > tp-yt-paper-item-body:first-child > div:first-child",
                        "ytd-comments-header-renderer a.yt-dropdown-menu > tp-yt-paper-item:first-child > tp-yt-paper-item-body:first-child > div:first-child");
    });

    waitForElement("yt-sort-filter-sub-menu-renderer yt-dropdown-menu:last-of-type").then(function() {
        restoreDropdown("yt-sort-filter-sub-menu-renderer #icon-label.yt-dropdown-menu",
                        "yt-sort-filter-sub-menu-renderer a.yt-dropdown-menu:nth-child(3) > tp-yt-paper-item:first-child > tp-yt-paper-item-body:first-child > div:first-child",
                        "yt-sort-filter-sub-menu-renderer a.yt-dropdown-menu > tp-yt-paper-item:first-child > tp-yt-paper-item-body:first-child > div:first-child");
    });

    // remove ambient mode player menu item
    waitForElement("path[d='M21 7v10H3V7h18m1-1H2v12h20V6zM11.5 2v3h1V2h-1zm1 17h-1v3h1v-3zM3.79 3 6 5.21l.71-.71L4.5 2.29 3.79 3zm2.92 16.5L6 18.79 3.79 21l.71.71 2.21-2.21zM19.5 2.29 17.29 4.5l.71.71L20.21 3l-.71-.71zm0 19.42.71-.71L18 18.79l-.71.71 2.21 2.21z']")
        .then(elm => elm.closest(".ytp-menuitem").remove());
}

window.addEventListener("yt-page-data-updated", removePlayerElements, false);
window.addEventListener("yt-page-data-updated", setupUpdateDependentElements, false);
// init functions
genSettings();
patch_css();
gen_history();
gen_aspect_fix();
subbutton();
counterstuff();
tempcssfix();