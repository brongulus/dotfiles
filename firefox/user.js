// about:support > open directory (profile)

user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.aboutwelcome.didSeeFinalScreen", true);
user_pref("browser.preonboarding.splashShown", true);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("signon.rememberSignons", false);

// Use s- instead of C-
user_pref("ui.key.accelKey", 91);
user_pref("browser.nova.enabled", false);
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("apz.kinetic_scroll.enabled", true);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Enable vertical tabs and hover expansion
user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.verticalTabs.dragToPinPromo.dismissed", true);
user_pref("sidebar.visibility", "expand-on-hover");
user_pref("sidebar.animation.expand-on-hover.duration-ms", 50);

// No "Intelligence" please
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ai.control.linkPreviewKeyPoints", "blocked");
user_pref("browser.ai.control.pdfjsAltText", "blocked");
user_pref("browser.ai.control.sidebarChatbot", "blocked");
user_pref("browser.ai.control.smartTabGroups", "blocked");
user_pref("browser.ai.control.smartWindow", "blocked");
user_pref("browser.ai.control.speechRecognition", "blocked");
user_pref("browser.ai.control.translations", "blocked");

// Cleaner newtab page
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// No "do evil" engine please
user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
user_pref("browser.urlbar.placeholderName.private", "DuckDuckGo");
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
user_pref("browser.urlbar.suggest.engines", false);
