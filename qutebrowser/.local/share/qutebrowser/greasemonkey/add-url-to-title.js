// ==UserScript==
// @name New Script
// @namespace Violentmonkey Scripts
// @grant none
// ==/UserScript==
let oriTitle = document.title;

document.title = oriTitle + ' - ' + window.location.hostname

