var REDIPS={};REDIPS.drag=function(){var e,l,n,t,o,d,r,i,c,a,s,u,m,f,g,h,p,y,w,E,v,_,I,N=null,P=0,S=0,D=null,b=null,R={page:{x:0,y:0},div:{x:0,y:0},flag:{x:0,y:0}},x=null,C=[],Y=[],X=0,T=0,k=[],O=[],B=null,L=null,j=null,W=null,H=null,A=null,V=null,z=null,K=null,U=null,$=null,q=!1,F=!1,G="#E7AB83",J=25,M=20,Q={div:[],cname:"only",other:"deny"},Z={action:"deny",cname:"mark",exception:[]},el="dotted",ll="trash",nl=!1,tl="multiple",ol=!0,dl=null,rl=null,il=null,cl=null,al=!1;return e=function(e){var t,o,d,i;for(void 0===e&&(e="drag"),B=document.getElementById(e),document.getElementById("obj_new")||(i=document.createElement("div"),i.id="obj_new",i.style.width=i.style.height="1px",B.appendChild(i)),l(),r(),window.onresize=r,w("init"),o=B.getElementsByTagName("img"),t=0;t<o.length;t++)o[t].onmousemove=n;B.onselectstart=function(e){return d=e||window.event,p(d)?void 0:(d.ctrlKey&&document.selection.clear(),!1)},window.onscroll=s},l=function(){var e,l,n,t,o;for(o=B.getElementsByTagName("table"),e=0,l=0;e<o.length;e++){t=!0,n=o[e].parentNode;do{if(n.id===B.id){t=!1;break}if("TABLE"===n.nodeName)break;n=n.parentNode}while(n);t||(Y[l]=o[e],l++)}},n=function(){return!1},t=function(e){var n,t,r=e||window.event;return p(r)?!0:(REDIPS.drag.obj_old=F=q||this,REDIPS.drag.obj=q=this,B!==q.container&&(B=q.container,l(),s()),-1===q.className.indexOf("clone")&&(q.style.zIndex=999),i(r),H=j,z=A,$=K,REDIPS.drag.source_cell=dl=Y[H].rows[z].cells[$],REDIPS.drag.current_cell=rl=dl,REDIPS.drag.previous_cell=il=dl,t=r.which?r.which:r.button,1===t&&(X=0,T=0,document.onmousemove=d,document.onmouseup=o,REDIPS.drag.myhandler_clicked(),q.setCapture&&q.setCapture()),(null!==j||null!==A||null!==K)&&(x=Y[j].rows[A].cells[K].style.backgroundColor),n=a(q),N=[r.clientY-n[0],n[1]-r.clientX,n[2]-r.clientY,r.clientX-n[3]],!1)},o=function(e){var l,n,t,o,d=e||window.event;if(q.releaseCapture&&q.releaseCapture(),document.onmousemove=null,document.onmouseup=null,q.style.left=0,q.style.top=0,q.style.zIndex=10,q.style.position="static",D=document.documentElement.scrollWidth,b=document.documentElement.scrollHeight,R.flag.x=R.flag.y=0,1!==T||null!==j&&null!==A&&null!==K)if(null===j||null===A||null===K)REDIPS.drag.myhandler_notmoved();else{if(j<Y.length?(l=Y[j],REDIPS.drag.target_cell=cl=l.rows[A].cells[K],REDIPS.drag.top_cell=l.rows[0].cells[K]):null===W||null===V||null===U?(l=Y[H],REDIPS.drag.target_cell=cl=l.rows[z].cells[$]):(l=Y[W],REDIPS.drag.target_cell=cl=l.rows[V].cells[U]),cl.style.backgroundColor=x,0===X)REDIPS.drag.myhandler_notmoved(),cl.appendChild(q);else if(1===T&&H===j&&z===A&&$===K)q.parentNode.removeChild(q),k[F.id]-=1,REDIPS.drag.myhandler_notcloned();else if(1===T&&REDIPS.drag.delete_cloned===!0&&(d.clientX<l.offset[3]||d.clientX>l.offset[1]||d.clientY<l.offset[0]||d.clientY>l.offset[2]))q.parentNode.removeChild(q),k[F.id]-=1,REDIPS.drag.myhandler_notcloned();else if(cl.className.indexOf(REDIPS.drag.trash)>-1)q.parentNode.removeChild(q),REDIPS.drag.trash_ask?setTimeout(y,10):(REDIPS.drag.myhandler_deleted(),1===T&&h());else if("switch"===REDIPS.drag.drop_option){for(q.parentNode.removeChild(q),t=cl.getElementsByTagName("DIV"),o=t.length,n=0;o>n;n++)void 0!==t[0]&&dl.appendChild(t[0]);cl.appendChild(q),o?(REDIPS.drag.myhandler_switched(),REDIPS.drag.myhandler_dropped(cl),1===T&&h()):(REDIPS.drag.myhandler_dropped(cl),1===T&&h())}else if("overwrite"===REDIPS.drag.drop_option){for(t=cl.getElementsByTagName("DIV"),o=t.length,n=0;o>n;n++)cl.removeChild(t[0]);cl.appendChild(q),REDIPS.drag.myhandler_dropped(cl),1===T&&h()}else cl.appendChild(q),REDIPS.drag.myhandler_dropped(cl),1===T&&h();null!==H&&null!==z&&(Y[H].rows[z].className=Y[H].rows[z].className),cl.parentNode.className=cl.parentNode.className,s()}else q.parentNode.removeChild(q),k[F.id]-=1,REDIPS.drag.myhandler_notcloned();W=V=U=null},d=function(e){var l,n,t,o=e||window.event,d=REDIPS.drag.bound;for(0===X&&(q.className.indexOf("clone")>-1||REDIPS.drag.clone_ctrlKey===!0&&o.ctrlKey)?(g(),T=1,REDIPS.drag.myhandler_cloned(),c()):0===X&&(REDIPS.drag.myhandler_moved(),c(),q.setCapture&&q.setCapture(),q.style.position="fixed"),X=1,o.clientX>N[3]&&o.clientX<P-N[1]&&(q.style.left=o.clientX-N[3]+"px"),o.clientY>N[0]&&o.clientY<S-N[2]&&(q.style.top=o.clientY-N[0]+"px"),o.clientX<L[1]&&o.clientX>L[3]&&o.clientY<L[2]&&o.clientY>L[0]&&(o.clientX<O[3]||o.clientX>O[1]||o.clientY<O[0]||o.clientY>O[2])&&(i(o),j<Y.length&&(j!==W||A!==V||K!==U)&&(null!==W&&null!==V&&null!==U&&(Y[W].rows[V].cells[U].style.backgroundColor=x,REDIPS.drag.previous_cell=il=Y[W].rows[V].cells[U],REDIPS.drag.current_cell=rl=Y[j].rows[A].cells[K],"switching"===REDIPS.drag.drop_option&&_(rl,il),REDIPS.drag.myhandler_changed(),s(),i(o)),c())),R.page.x=d-(P/2>o.clientX?o.clientX-N[3]:P-o.clientX-N[1]),R.page.x>0?(R.page.x>d&&(R.page.x=d),t=u()[0],R.page.x*=o.clientX<P/2?-1:1,R.page.x<0&&0>=t||R.page.x>0&&t>=D-P||0===R.flag.x++&&(window.onscroll=null,m(window))):R.page.x=0,R.page.y=d-(S/2>o.clientY?o.clientY-N[0]:S-o.clientY-N[2]),R.page.y>0?(R.page.y>d&&(R.page.y=d),t=u()[1],R.page.y*=o.clientY<S/2?-1:1,R.page.y<0&&0>=t||R.page.y>0&&t>=b-S||0===R.flag.y++&&(window.onscroll=null,f(window))):R.page.y=0,n=0;n<C.length;n++){if(l=C[n],o.clientX<l.offset[1]&&o.clientX>l.offset[3]&&o.clientY<l.offset[2]&&o.clientY>l.offset[0]){R.div.x=d-(l.midstX>o.clientX?o.clientX-N[3]-l.offset[3]:l.offset[1]-o.clientX-N[1]),R.div.x>0?(R.div.x>d&&(R.div.x=d),R.div.x*=o.clientX<l.midstX?-1:1,0===R.flag.x++&&(l.div.onscroll=null,m(l.div))):R.div.x=0,R.div.y=d-(l.midstY>o.clientY?o.clientY-N[0]-l.offset[0]:l.offset[2]-o.clientY-N[2]),R.div.y>0?(R.div.y>d&&(R.div.y=d),R.div.y*=o.clientY<l.midstY?-1:1,0===R.flag.y++&&(l.div.onscroll=null,f(l.div))):R.div.y=0;break}R.div.x=R.div.y=0}o.cancelBubble=!0,o.stopPropagation&&o.stopPropagation()},r=function(){"number"==typeof window.innerWidth?(P=window.innerWidth,S=window.innerHeight):document.documentElement&&(document.documentElement.clientWidth||document.documentElement.clientHeight)?(P=document.documentElement.clientWidth,S=document.documentElement.clientHeight):document.body&&(document.body.clientWidth||document.body.clientHeight)&&(P=document.body.clientWidth,S=document.body.clientHeight),D=document.documentElement.scrollWidth,b=document.documentElement.scrollHeight,s()},i=function(e){var l,n,t,o,d,r,i,c;for(j=0;j<Y.length;j++)if(Y[j].offset[3]<e.clientX&&e.clientX<Y[j].offset[1]&&Y[j].offset[0]<e.clientY&&e.clientY<Y[j].offset[2]){for(n=Y[j].row_offset,A=0;A<n.length-1&&n[A][0]<e.clientY&&(O[0]=n[A][0],O[2]=n[A+1][0],!(e.clientY<=O[2]));A++);A===n.length-1&&(O[0]=n[A][0],O[2]=Y[j].offset[2]);do for(t=Y[j].rows[A].cells.length-1,K=t;K>=0&&(O[3]=n[A][3]+Y[j].rows[A].cells[K].offsetLeft,O[1]=O[3]+Y[j].rows[A].cells[K].offsetWidth,!(O[3]<=e.clientX&&e.clientX<=O[1]));K--);while(-1===K&&A-->0);if((0>A||0>K)&&(j=W,A=V,K=U),l=Y[j].rows[A].cells[K],-1===l.className.indexOf(REDIPS.drag.trash))if(r=l.className.indexOf(REDIPS.drag.only.cname)>-1?!0:!1,r===!0){if(-1===l.className.indexOf(Q.div[q.id])){null!==W&&null!==V&&null!==U&&(j=W,A=V,K=U);break}}else{if(void 0!==Q.div[q.id]&&"deny"===Q.other){null!==W&&null!==V&&null!==U&&(j=W,A=V,K=U);break}if(d=l.className.indexOf(REDIPS.drag.mark.cname)>-1?!0:!1,(d===!0&&"deny"===REDIPS.drag.mark.action||d===!1&&"allow"===REDIPS.drag.mark.action)&&-1===l.className.indexOf(Z.exception[q.id])){null!==W&&null!==V&&null!==U&&(j=W,A=V,K=U);break}}if(i=l.className.indexOf("single")>-1?!0:!1,("single"===REDIPS.drag.drop_option||i)&&l.childNodes.length>0){if(1===l.childNodes.length&&3===l.firstChild.nodeType)break;for(o=!1,c=l.childNodes.length-1;c>=0;c--)if(o=!0,l.childNodes[c].className&&l.childNodes[c].className.indexOf("drag")>-1){o=!0;break}if(o&&null!==W&&null!==V&&null!==U&&(H!==j||z!==A||$!==K)){j=W,A=V,K=U;break}}break}},c=function(){j<Y.length&&null!==j&&null!==A&&null!==K&&(x=Y[j].rows[A].cells[K].style.backgroundColor,Y[j].rows[A].cells[K].style.backgroundColor=REDIPS.drag.hover_color,W=j,V=A,U=K)},a=function(e,l){var n=u(),t=0-n[0],o=0-n[1],d=e;if(void 0===l){do t+=e.offsetLeft-e.scrollLeft,o+=e.offsetTop-e.scrollTop,e=e.offsetParent;while(e&&"BODY"!==e.nodeName)}else do t+=e.offsetLeft,o+=e.offsetTop,e=e.offsetParent;while(e&&"BODY"!==e.nodeName);return[o,t+d.offsetWidth,o+d.offsetHeight,t]},s=function(){var e,l,n,t;for(e=0;e<Y.length;e++){for(n=[],l=Y[e].rows.length-1;l>=0;l--)n[l]=a(Y[e].rows[l]);Y[e].offset=a(Y[e]),Y[e].row_offset=n}for(L=a(B),e=0;e<C.length;e++)t=a(C[e].div,1),C[e].offset=t,C[e].midstX=(t[1]+t[3])/2,C[e].midstY=(t[0]+t[2])/2},u=function(){var e,l;return"number"==typeof window.pageYOffset?(e=window.pageXOffset,l=window.pageYOffset):document.body&&(document.body.scrollLeft||document.body.scrollTop)?(e=document.body.scrollLeft,l=document.body.scrollTop):document.documentElement&&(document.documentElement.scrollLeft||document.documentElement.scrollTop)?(e=document.documentElement.scrollLeft,l=document.documentElement.scrollTop):e=l=0,[e,l]},m=function(e){var l,n,t,o,d;"object"==typeof e&&(I=e),I===window?(t=n=u()[0],o=D-P,d=R.page.x):(t=I.scrollLeft,o=I.scrollWidth-I.clientWidth,d=R.div.x),R.flag.x>0&&(0>d&&t>0||d>0&&o>t)?(I===window?(window.scrollBy(d,0),t=u()[0],l=parseInt(q.style.left,10),isNaN(l)&&(l=0)):I.scrollLeft+=d,setTimeout(REDIPS.drag.autoscrollX,REDIPS.drag.speed)):(s(),I.onscroll=s,R.flag.x=0,O=[0,0,0,0])},f=function(e){var l,n,t,o,d;"object"==typeof e&&(I=e),I===window?(t=n=u()[1],o=b-S,d=R.page.y):(t=I.scrollTop,o=I.scrollHeight-I.clientHeight,d=R.div.y),R.flag.y>0&&(0>d&&t>0||d>0&&o>t)?(I===window?(window.scrollBy(0,d),t=u()[1],l=parseInt(q.style.top,10),isNaN(l)&&(l=0)):I.scrollTop+=d,setTimeout(REDIPS.drag.autoscrollY,REDIPS.drag.speed)):(s(),I.onscroll=s,R.flag.y=0,O=[0,0,0,0])},g=function(){var e,l,n=q.cloneNode(!0);document.getElementById("obj_new").appendChild(n),n.setCapture&&n.setCapture(),n.style.zIndex=999,n.style.position="fixed",e=a(q),l=a(n),n.style.top=e[0]-l[0]+"px",n.style.left=e[3]-l[3]+"px",n.onmousedown=t,n.className=n.className.replace("clone",""),void 0===k[q.id]&&(k[q.id]=0),n.id=q.id+"c"+k[q.id],k[q.id]+=1,n.container=q.container,REDIPS.drag.obj_old=F=q,REDIPS.drag.obj=q=n},h=function(){var e,l,n,t;t=F.className,e=t.match(/climit(\d)_(\d+)/),null!==e&&(l=parseInt(e[1],10),n=parseInt(e[2],10),n-=1,t=t.replace(/climit\d_\d+/g,""),0>=n?(t=t.replace("clone",""),2===l?(t=t.replace("drag",""),F.onmousedown=null,F.style.cursor="auto",REDIPS.drag.myhandler_clonedend2()):REDIPS.drag.myhandler_clonedend1()):t=t+" climit"+l+"_"+n,t=t.replace(/^\s+|\s+$/g,"").replace(/\s{2,}/g," "),F.className=t)},p=function(e){var l,n;switch(n=e.srcElement?e.srcElement.tagName:e.target.tagName){case"A":case"INPUT":case"SELECT":case"OPTION":case"TEXTAREA":l=!0;break;default:l=!1}return l},y=function(){var e,l="element";e=q.className.indexOf("t1")>0?"green":q.className.indexOf("t2")>0?"blue":"orange",q.getElementsByTagName("INPUT").length||q.getElementsByTagName("SELECT").length?l="form element":(q.innerText||q.textContent)&&(l='"'+(q.innerText||q.textContent)+'"'),confirm("Delete "+l+" ("+e+") from\n table "+H+", row "+z+" and column "+$+"?")?(REDIPS.drag.myhandler_deleted(),1===T&&h()):(1!==T&&(Y[H].rows[z].cells[$].appendChild(q),s()),REDIPS.drag.myhandler_undeleted())},w=function(e,l){var n,o,d,r,i,c,u,m=[];for(e===!0||"init"===e?(i=t,d="solid",r="move"):(i=null,d=REDIPS.drag.border_disabled,r="auto"),void 0===l?m=B.getElementsByTagName("div"):m[0]=document.getElementById(l),n=0,o=0;n<m.length;n+=1)m[n].className.indexOf("drag")>-1?(m[n].onmousedown=i,m[n].style.borderStyle=d,m[n].style.cursor=r,m[n].enabled=e,m[n].container=B):"init"===e&&(c=E(m[n],"overflow"),"visible"!==c&&(m[n].onscroll=s,u=a(m[n],1),C[o]={div:m[n],offset:u,midstX:(u[1]+u[3])/2,midstY:(u[0]+u[2])/2},o++))},E=function(e,l){var n;return e.currentStyle?n=e.currentStyle[l]:window.getComputedStyle&&(n=document.defaultView.getComputedStyle(e,null).getPropertyValue(l)),n},v=function(e){var l,n,t,o,d,r,i,c,a,s="";for(void 0===e?(l=0,n=Y.length-1):l=n=0>e||e>Y.length-1?0:e,r=l;n>=r;r++)for(t=Y[r].rows.length,i=0;t>i;i++)for(o=Y[r].rows[i].cells.length,c=0;o>c;c++)if(d=Y[r].rows[i].cells[c],d.childNodes.length>0)for(a=0;a<d.childNodes.length;a++)"DIV"===d.childNodes[a].tagName&&(s+="p[]="+d.childNodes[a].id+"_"+r+"_"+i+"_"+c+"&");return s=s.substring(0,s.length-1)},_=function(e,l){var n,t;if(e!==l)for(t=e.childNodes.length,n=0;t>n;n++)l.appendChild(e.childNodes[0])},{obj:q,obj_old:F,source_cell:dl,previous_cell:il,current_cell:rl,target_cell:cl,hover_color:G,bound:J,speed:M,only:Q,mark:Z,border_disabled:el,trash:ll,trash_ask:nl,drop_option:tl,delete_cloned:ol,cloned_id:k,clone_ctrlKey:al,init:e,enable_drag:w,save_content:v,move_object:_,autoscrollX:m,autoscrollY:f,handler_onmousedown:t,myhandler_clicked:function(){},myhandler_moved:function(){},myhandler_notmoved:function(){},myhandler_dropped:function(){},myhandler_switched:function(){},myhandler_changed:function(){},myhandler_cloned:function(){},myhandler_clonedend1:function(){},myhandler_clonedend2:function(){},myhandler_notcloned:function(){},myhandler_deleted:function(){},myhandler_undeleted:function(){}}}();