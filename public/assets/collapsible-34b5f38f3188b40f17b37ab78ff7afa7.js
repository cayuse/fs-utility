!function(e){function n(n,o){var i=e.extend({},e.fn.collapsible.defaults,o),s=[];return n.each(function(){var n=e(this);t(n,i),"mouseenter"==i.bind&&n.bind("mouseenter",function(e){e.preventDefault(),l(n,i)}),"mouseover"==i.bind&&n.bind("mouseover",function(e){e.preventDefault(),l(n,i)}),"click"==i.bind&&n.bind("click",function(e){e.preventDefault(),l(n,i)}),"dblclick"==i.bind&&n.bind("dblclick",function(e){e.preventDefault(),l(n,i)});var o=n.attr("id");if(u(i))if(h(i)){var c=C(o,i);c===!1?(n.addClass(i.cssClose),i.loadClose(n,i)):(n.addClass(i.cssOpen),i.loadOpen(n,i),s.push(o))}else r=m(o,i),r===!1?(n.addClass(i.cssClose),i.loadClose(n,i)):(n.addClass(i.cssOpen),i.loadOpen(n,i),s.push(o));else{var r=m(o,i);r===!1?(n.addClass(i.cssClose),i.loadClose(n,i)):(n.addClass(i.cssOpen),i.loadOpen(n,i),s.push(o))}}),s.length>0&&u(i)?p(s.toString(),i):p("",i),n}function o(e){return e.data("collapsible-opts")}function t(e,n){return e.data("collapsible-opts",n)}function i(e,n){return e.hasClass(n.cssClose)}function s(e,n){if(e.addClass(n.cssClose).removeClass(n.cssOpen),n.animateClose(e,n),u(n)){var o=e.attr("id");d(o,n)}}function c(e,n){if(e.removeClass(n.cssClose).addClass(n.cssOpen),n.animateOpen(e,n),u(n)){var o=e.attr("id");f(o,n)}}function l(e,n){return i(e,n)?c(e,n):s(e,n),!1}function r(n,o){e.each(n,function(n,t){i(e(t),o)&&c(e(t),o)})}function a(n,o){e.each(n,function(n,t){i(e(t),o)||s(e(t),o)})}function u(n){return e.cookie&&""!=n.cookieName?!0:!1}function f(n,o){if(!u(o))return!1;if(!h(o))return p(n,o),!0;if(C(n,o))return!0;var t=decodeURIComponent(e.cookie(o.cookieName)),i=t.split(",");return i.push(n),p(i.toString(),o),!0}function d(n,o){if(!u(o))return!1;if(!h(o))return!0;var t=C(n,o);if(t===!1)return!0;var i=decodeURIComponent(e.cookie(o.cookieName)),s=i.split(",");return s.splice(t,1),p(s.toString(),o),!0}function p(n,o){return u(o)?(e.cookie(o.cookieName,n,o.cookieOptions),!0):!1}function C(n,o){if(!u(o))return!1;if(!h(o))return!1;var t=decodeURIComponent(e.cookie(o.cookieName)),i=t.split(","),s=e.inArray(n,i);return-1==s?!1:s}function h(n){return u(n)?null===e.cookie(n.cookieName)?!1:!0:!1}function m(n,o){var t=v(o),i=e.inArray(n,t);return-1==i?!1:i}function v(e){var n=[];return""!=e.defaultOpen&&(n=e.defaultOpen.split(",")),n}e.fn.collapsible=function(n,o){return!this||this.length<1?this:"string"==typeof n?e.fn.collapsible.dispatcher[n](this,o):e.fn.collapsible.dispatcher._create(this,n)},e.fn.collapsible.dispatcher={_create:function(e,o){n(e,o)},toggle:function(e){return l(e,o(e)),e},open:function(e){return c(e,o(e)),e},close:function(e){return s(e,o(e)),e},collapsed:function(e){return i(e,o(e))},openAll:function(e){return r(e,o(e))},closeAll:function(e){return a(e,o(e))}},e.fn.collapsible.defaults={cssClose:"collapse-close",cssOpen:"collapse-open",cookieName:"collapsible",cookieOptions:{path:"/",expires:7,domain:"",secure:""},defaultOpen:"",speed:"slow",bind:"click",animateOpen:function(e,n){e.next().stop(!0,!0).slideDown(n.speed)},animateClose:function(e,n){e.next().stop(!0,!0).slideUp(n.speed)},loadOpen:function(e){e.next().show()},loadClose:function(e){e.next().hide()}}}(jQuery);