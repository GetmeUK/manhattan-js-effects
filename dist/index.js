!function(e,o){"object"==typeof exports&&"object"==typeof module?module.exports=o():"function"==typeof define&&define.amd?define([],o):"object"==typeof exports?exports.ManhattanEffects=o():e.ManhattanEffects=o()}(this,function(){return function(e){function __webpack_require__(t){if(o[t])return o[t].exports;var r=o[t]={exports:{},id:t,loaded:!1};return e[t].call(r.exports,r,r.exports,__webpack_require__),r.loaded=!0,r.exports}var o={};return __webpack_require__.m=e,__webpack_require__.c=o,__webpack_require__.p="",__webpack_require__(0)}([function(e,o,t){e.exports=t(1)},function(e,o){var t;t=function(){var e,o;return duration<=0?void(callback&&callback()):(e=to-element.scrollTop,o=e/duration*5,void setTimeout(function(){var e;return element.scrollTop=element.scrollTop+o,e=document.body.scrollHeight-element.scrollTop<=window.innerHeight,element.scrollTop===to||e?void(callback&&callback()):t(element,to,duration-5,callback)},5))},e.exports={scrollTo:t}}])});