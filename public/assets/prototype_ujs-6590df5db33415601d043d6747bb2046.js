!function(){function e(e){var t=document.createElement("div");e="on"+e;var n=e in t;return n||(t.setAttribute(e,"return;"),n="function"==typeof t[e]),t=null,n}function t(e){return Object.isElement(e)&&"FORM"==e.nodeName.toUpperCase()}function n(e){if(Object.isElement(e)){var t=e.nodeName.toUpperCase();return"INPUT"==t||"SELECT"==t||"TEXTAREA"==t}return!1}function a(e){var t,n,a,r=e.fire("ajax:before");return r.stopped?!1:("form"===e.tagName.toLowerCase()?(t=e.readAttribute("method")||"post",n=e.readAttribute("action"),a=e.serialize({submit:e.retrieve("rails:submit-button")}),e.store("rails:submit-button",null)):(t=e.readAttribute("data-method")||"get",n=e.readAttribute("href"),a={}),new Ajax.Request(n,{method:t,parameters:a,evalScripts:!0,onCreate:function(t){e.fire("ajax:create",t)},onComplete:function(t){e.fire("ajax:complete",t)},onSuccess:function(t){e.fire("ajax:success",t)},onFailure:function(t){e.fire("ajax:failure",t)}}),void e.fire("ajax:after"))}function r(e,t,n){e.insert(new Element("input",{type:"hidden",name:t,value:n}))}function i(e){var t=e.readAttribute("data-method"),n=e.readAttribute("href"),a=$$("meta[name=csrf-param]")[0],i=$$("meta[name=csrf-token]")[0],o=new Element("form",{method:"POST",action:n,style:"display: none;"});$(e.parentNode).insert(o),"post"!==t&&r(o,"_method",t),a&&r(o,a.readAttribute("content"),i.readAttribute("content")),o.submit()}function o(e){e.select("input[type=submit][data-disable-with]").each(function(e){e.store("rails:original-value",e.getValue()),e.setValue(e.readAttribute("data-disable-with")).disable()})}function u(e){e.select("input[type=submit][data-disable-with]").each(function(e){e.setValue(e.retrieve("rails:original-value")).enable()})}function m(e){var t=e.readAttribute("data-confirm");return!t||confirm(t)}var s=e("submit"),c=e("change");s&&c||(Event.Handler.prototype.initialize=Event.Handler.prototype.initialize.wrap(function(e,a,r,i,o){e(a,r,i,o),(!s&&"submit"==this.eventName&&!t(this.element)||!c&&"change"==this.eventName&&!n(this.element))&&(this.eventName="emulated:"+this.eventName)})),s||document.on("focusin","form",function(e,t){t.retrieve("emulated:submit")||(t.on("submit",function(e){var n=t.fire("emulated:submit",e,!0);n.returnValue===!1&&e.preventDefault()}),t.store("emulated:submit",!0))}),c||document.on("focusin","input, select, textarea",function(e,t){t.retrieve("emulated:change")||(t.on("change",function(e){t.fire("emulated:change",e,!0)}),t.store("emulated:change",!0))}),document.on("click","a[data-confirm], a[data-remote], a[data-method]",function(e,t){return m(t)?void(t.readAttribute("data-remote")?(a(t),e.stop()):t.readAttribute("data-method")&&(i(t),e.stop())):(e.stop(),!1)}),document.on("click","form input[type=submit], form button[type=submit], form button:not([type])",function(e,t){e.findElement("form").store("rails:submit-button",t.name||!1)}),document.on("submit",function(e){var t=e.findElement();return m(t)?void(t.readAttribute("data-remote")?(a(t),e.stop()):o(t)):(e.stop(),!1)}),document.on("ajax:create","form",function(e,t){t==e.findElement()&&o(t)}),document.on("ajax:complete","form",function(e,t){t==e.findElement()&&u(t)}),Ajax.Responders.register({onCreate:function(e){var t=$$("meta[name=csrf-token]")[0];if(t){var n="X-CSRF-Token",a=t.readAttribute("content");e.options.requestHeaders||(e.options.requestHeaders={}),e.options.requestHeaders[n]=a}}})}();