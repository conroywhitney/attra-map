function d(t){return function(e){this[t]=e}}function f(t){return function(){return this[t]}}function l(t,e,o){this.extend(l,google.maps.OverlayView),this.b=t,this.a=[],this.f=[],this.da=[53,56,66,78,90],this.j=[],this.A=!1,o=o||{},this.g=o.gridSize||60,this.l=o.minimumClusterSize||2,this.K=o.maxZoom||null,this.j=o.styles||[],this.Y=o.imagePath||this.R,this.X=o.imageExtension||this.Q,this.P=!0,void 0!=o.zoomOnClick&&(this.P=o.zoomOnClick),this.r=!1,void 0!=o.averageCenter&&(this.r=o.averageCenter),m(this),this.setMap(t),this.L=this.b.getZoom();var i=this;google.maps.event.addListener(this.b,"zoom_changed",function(){var t=i.b.getZoom(),e=i.b.minZoom||0,o=Math.min(i.b.maxZoom||100,i.b.mapTypes[i.b.getMapTypeId()].maxZoom),t=Math.min(Math.max(t,e),o);i.L!=t&&(i.L=t,i.m())}),google.maps.event.addListener(this.b,"idle",function(){i.i()}),e&&(e.length||Object.keys(e).length)&&this.C(e,!1)}function m(t){if(!t.j.length)for(var e,o=0;e=t.da[o];o++)t.j.push({url:t.Y+(o+1)+"."+t.X,height:e,width:e})}function s(t,e){e.s=!1,e.draggable&&google.maps.event.addListener(e,"dragend",function(){e.s=!1,t.M()}),t.a.push(e)}function t(t,e){var o=-1;if(t.a.indexOf)o=t.a.indexOf(e);else for(var i,n=0;i=t.a[n];n++)if(i==e){o=n;break}return-1==o?!1:(e.setMap(null),t.a.splice(o,1),!0)}function p(t){if(t.A)for(var e,o=new google.maps.LatLngBounds(t.b.getBounds().getSouthWest(),t.b.getBounds().getNorthEast()),o=t.v(o),i=0;e=t.a[i];i++)if(!e.s&&o.contains(e.getPosition())){for(var n=t,r=4e4,a=null,s=0,l=void 0;l=n.f[s];s++){var p=l.getCenter();if(p){var h=e.getPosition();if(p&&h)var c=(h.lat()-p.lat())*Math.PI/180,g=(h.lng()-p.lng())*Math.PI/180,p=Math.sin(c/2)*Math.sin(c/2)+Math.cos(p.lat()*Math.PI/180)*Math.cos(h.lat()*Math.PI/180)*Math.sin(g/2)*Math.sin(g/2),p=12742*Math.atan2(Math.sqrt(p),Math.sqrt(1-p));else p=0;r>p&&(r=p,a=l)}}a&&a.F.contains(e.getPosition())?a.q(e):(l=new v(n),l.q(e),n.f.push(l))}}function v(t){this.k=t,this.b=t.getMap(),this.g=t.I(),this.l=t.l,this.r=t.r,this.d=null,this.a=[],this.F=null,this.n=new w(this,t.w())}function A(t){var e=new google.maps.LatLngBounds(t.d,t.d);t.F=t.k.v(e)}function w(t,e){t.k.extend(w,google.maps.OverlayView),this.j=e,this.u=t,this.d=null,this.b=t.getMap(),this.B=this.c=null,this.t=!1,this.setMap(this.b)}function C(t,e){var o=t.getProjection().fromLatLngToDivPixel(e);return o.x-=parseInt(t.p/2,10),o.y-=parseInt(t.h/2,10),o}function B(t){t.c&&(t.c.style.display="none"),t.t=!1}function D(t,e){var o=[];return o.push("background-image:url("+t.ea+");"),o.push("background-position:"+(t.D?t.D:"0 0")+";"),"object"==typeof t.e?(o.push("number"==typeof t.e[0]&&0<t.e[0]&&t.e[0]<t.h?"height:"+(t.h-t.e[0])+"px; padding-top:"+t.e[0]+"px;":"height:"+t.h+"px; line-height:"+t.h+"px;"),o.push("number"==typeof t.e[1]&&0<t.e[1]&&t.e[1]<t.p?"width:"+(t.p-t.e[1])+"px; padding-left:"+t.e[1]+"px;":"width:"+t.p+"px; text-align:center;")):o.push("height:"+t.h+"px; line-height:"+t.h+"px; width:"+t.p+"px; text-align:center;"),o.push("cursor:pointer; top:"+e.y+"px; left:"+e.x+"px; color:"+(t.N?t.N:"black")+"; position:absolute; font-size:"+(t.O?t.O:11)+"px; font-family:Arial,sans-serif; font-weight:bold"),o.join("")}var k;k=l.prototype,k.R="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclusterer/images/m",k.Q="png",k.extend=function(t,e){return function(t){for(var e in t.prototype)this.prototype[e]=t.prototype[e];return this}.apply(t,[e])},k.onAdd=function(){this.A||(this.A=!0,p(this))},k.draw=function(){},k.T=function(){for(var t,e=this.o(),o=new google.maps.LatLngBounds,i=0;t=e[i];i++)o.extend(t.getPosition());this.b.fitBounds(o)},k.w=f("j"),k.o=f("a"),k.W=function(){return this.a.length},k.ca=d("K"),k.J=f("K"),k.G=function(t,e){for(var o=0,i=t.length,n=i;0!==n;)n=parseInt(n/10,10),o++;return o=Math.min(o,e),{text:i,index:o}},k.aa=d("G"),k.H=f("G"),k.C=function(t,e){if(t.length)for(var o,i=0;o=t[i];i++)s(this,o);else if(Object.keys(t).length)for(o in t)s(this,t[o]);e||this.i()},k.q=function(t,e){s(this,t),e||this.i()},k.Z=function(e,o){var i=t(this,e);return!o&&i?(this.m(),this.i(),!0):!1},k.$=function(e,o){for(var i,n=!1,r=0;i=e[r];r++)i=t(this,i),n=n||i;return!o&&n?(this.m(),this.i(),!0):void 0},k.V=function(){return this.f.length},k.getMap=f("b"),k.setMap=d("b"),k.I=f("g"),k.ba=d("g"),k.v=function(t){var e=this.getProjection(),o=new google.maps.LatLng(t.getNorthEast().lat(),t.getNorthEast().lng()),i=new google.maps.LatLng(t.getSouthWest().lat(),t.getSouthWest().lng()),o=e.fromLatLngToDivPixel(o);return o.x+=this.g,o.y-=this.g,i=e.fromLatLngToDivPixel(i),i.x-=this.g,i.y+=this.g,o=e.fromDivPixelToLatLng(o),e=e.fromDivPixelToLatLng(i),t.extend(o),t.extend(e),t},k.S=function(){this.m(!0),this.a=[]},k.m=function(t){for(var e,o=0;e=this.f[o];o++)e.remove();for(o=0;e=this.a[o];o++)e.s=!1,t&&e.setMap(null);this.f=[]},k.M=function(){var t=this.f.slice();this.f.length=0,this.m(),this.i(),window.setTimeout(function(){for(var e,o=0;e=t[o];o++)e.remove()},0)},k.i=function(){p(this)},k=v.prototype,k.q=function(t){var e;t:if(this.a.indexOf)e=-1!=this.a.indexOf(t);else{e=0;for(var o;o=this.a[e];e++)if(o==t){e=!0;break t}e=!1}if(e)return!1;if(this.d?this.r&&(o=this.a.length+1,e=(this.d.lat()*(o-1)+t.getPosition().lat())/o,o=(this.d.lng()*(o-1)+t.getPosition().lng())/o,this.d=new google.maps.LatLng(e,o),A(this)):(this.d=t.getPosition(),A(this)),t.s=!0,this.a.push(t),e=this.a.length,e<this.l&&t.getMap()!=this.b&&t.setMap(this.b),e==this.l)for(o=0;e>o;o++)this.a[o].setMap(null);if(e>=this.l&&t.setMap(null),t=this.b.getZoom(),(e=this.k.J())&&t>e)for(t=0;e=this.a[t];t++)e.setMap(this.b);else this.a.length<this.l?B(this.n):(e=this.k.H()(this.a,this.k.w().length),this.n.setCenter(this.d),t=this.n,t.B=e,t.c&&(t.c.innerHTML=e.text),e=Math.max(0,t.B.index-1),e=Math.min(t.j.length-1,e),e=t.j[e],t.ea=e.url,t.h=e.height,t.p=e.width,t.N=e.textColor,t.e=e.anchor,t.O=e.textSize,t.D=e.backgroundPosition,this.n.show());return!0},k.getBounds=function(){for(var t,e=new google.maps.LatLngBounds(this.d,this.d),o=this.o(),i=0;t=o[i];i++)e.extend(t.getPosition());return e},k.remove=function(){this.n.remove(),this.a.length=0,delete this.a},k.U=function(){return this.a.length},k.o=f("a"),k.getCenter=f("d"),k.getMap=f("b"),k=w.prototype,k.onAdd=function(){if(this.c=document.createElement("DIV"),this.t){var t=C(this,this.d);this.c.style.cssText=D(this,t),this.c.innerHTML=this.B.text}this.getPanes().overlayMouseTarget.appendChild(this.c);var e=this;google.maps.event.addDomListener(this.c,"click",function(){var t=e.u.k;google.maps.event.trigger(t,"clusterclick",e.u),t.P&&e.b.fitBounds(e.u.getBounds())})},k.draw=function(){if(this.t){var t=C(this,this.d);this.c.style.top=t.y+"px",this.c.style.left=t.x+"px"}},k.show=function(){if(this.c){var t=C(this,this.d);this.c.style.cssText=D(this,t),this.c.style.display=""}this.t=!0},k.remove=function(){this.setMap(null)},k.onRemove=function(){this.c&&this.c.parentNode&&(B(this),this.c.parentNode.removeChild(this.c),this.c=null)},k.setCenter=d("d"),window.MarkerClusterer=l,l.prototype.addMarker=l.prototype.q,l.prototype.addMarkers=l.prototype.C,l.prototype.clearMarkers=l.prototype.S,l.prototype.fitMapToMarkers=l.prototype.T,l.prototype.getCalculator=l.prototype.H,l.prototype.getGridSize=l.prototype.I,l.prototype.getExtendedBounds=l.prototype.v,l.prototype.getMap=l.prototype.getMap,l.prototype.getMarkers=l.prototype.o,l.prototype.getMaxZoom=l.prototype.J,l.prototype.getStyles=l.prototype.w,l.prototype.getTotalClusters=l.prototype.V,l.prototype.getTotalMarkers=l.prototype.W,l.prototype.redraw=l.prototype.i,l.prototype.removeMarker=l.prototype.Z,l.prototype.removeMarkers=l.prototype.$,l.prototype.resetViewport=l.prototype.m,l.prototype.repaint=l.prototype.M,l.prototype.setCalculator=l.prototype.aa,l.prototype.setGridSize=l.prototype.ba,l.prototype.setMaxZoom=l.prototype.ca,l.prototype.onAdd=l.prototype.onAdd,l.prototype.draw=l.prototype.draw,v.prototype.getCenter=v.prototype.getCenter,v.prototype.getSize=v.prototype.U,v.prototype.getMarkers=v.prototype.o,w.prototype.onAdd=w.prototype.onAdd,w.prototype.draw=w.prototype.draw,w.prototype.onRemove=w.prototype.onRemove,Object.keys=Object.keys||function(t){var e,o=[];for(e in t)t.hasOwnProperty(e)&&o.push(e);return o};var mod;mod=angular.module("infinite-scroll",[]),mod.directive("infiniteScroll",["$rootScope","$window","$timeout",function(t,e,o){return{link:function(i,n,r){var a,s,l,p;return e=angular.element(e),l=0,null!=r.infiniteScrollDistance&&i.$watch(r.infiniteScrollDistance,function(t){return l=parseInt(t,10)}),p=!0,a=!1,null!=r.infiniteScrollDisabled&&i.$watch(r.infiniteScrollDisabled,function(t){return p=!t,p&&a?(a=!1,s()):void 0}),s=function(){var o,s,h,c;return c=e.height()+e.scrollTop(),o=n.offset().top+n.height(),s=o-c,h=e.height()*l>=s,h&&p?t.$$phase?i.$eval(r.infiniteScroll):i.$apply(r.infiniteScroll):h?a=!0:void 0},e.on("scroll",s),i.$on("$destroy",function(){return e.off("scroll",s)}),o(function(){return r.infiniteScrollImmediateCheck?i.$eval(r.infiniteScrollImmediateCheck)?s():void 0:s()},0)}}}]);var app=angular.module("search",["ngRoute","ngSanitize","infinite-scroll"]).config(["$routeProvider",function(t){t.otherwise({templateUrl:"propertySearch.html"})}]).config(["$locationProvider",function(t){t.html5Mode(!0)}]).run(["$location","$rootElement",function(t,e){e.off("click")}]).factory("Contacts",function(){return new AlgoliaSearch("4FQPTMXLRJ","f2f48a01e99540374fb78edeace42012").initIndex("Listing_development")}).controller("SearchCtrl",function(t,e,o){t.hits=[],t.listings=[],t.hitCount="__",t.paginating=!1,t.searchbox={query:e.search().keywords||"",product:e.search().product||"",location:e.search().location||"",offering:e.search().offering||"",page:e.search().page||1,center:e.search().center||"39.3369535,-94.1065431",zoom:parseInt(e.search().zoom)||4,bounds:function(){console.log("bounds()");var e=t.map.$map.getBounds(),o=e.getNorthEast(),i=e.getSouthWest(),n=[o.lat(),o.lng(),i.lat(),i.lng()].join(",");return n},lat:function(){return parseFloat(t.searchbox.center.split(",")[0])},lon:function(){return parseFloat(t.searchbox.center.split(",")[1])}},t.map={initializing:!0,div:document.getElementById("map-canvas"),options:{zoom:t.searchbox.zoom,center:new google.maps.LatLng(t.searchbox.lat(),t.searchbox.lon()),scrollwheel:!1,mapTypeId:google.maps.MapTypeId.TERRAIN},$map:null,markers:[],infoWindow:null,markerCluster:null,initialize:function(){console.log("initialize()"),t.map.$map=new google.maps.Map(t.map.div,t.map.options),google.maps.event.addListener(t.map.$map,"idle",t.map.onDragOrZoom),google.maps.event.addListener(t.map.$map,"click",t.map.closeInfoWindow()),setTimeout(function(){t.map.initializing=!1},5e3)},cropMapToMarkers:function(){console.log("cropMapToMarkers()");for(var e=new google.maps.LatLngBounds,o=0;o<t.map.markers.length;o++){var i=t.map.markers[o],n=i.getPosition();e.extend(n)}t.map.$map.setCenter(e.getCenter()),t.map.$map.fitBounds(e)},onDragOrZoom:function(){console.log("onDragOrZoom()");var o=t.map.$map,i=o.getCenter().toUrlValue(),n=(o.getCenter(),o.getZoom());t.searchbox.center=i,t.searchbox.zoom=n,e.search("keywords",t.searchbox.query),e.search("center",i),e.search("zoom",n),e.search("page",1),t.search({global:!1})},clearMarkers:function(){if(console.log("clearMarkers()"),t.map.markers)for(var e=0;e<t.map.markers.length;e++)t.map.markers[e].setMap(null),t.map.markers=[];t.map.markerCluster&&t.map.markerCluster.clearMarkers()},closeInfoWindow:function(){null!==t.map.infoWindow&&t.map.infoWindow.close()},redrawMarkers:function(e){console.log("redrawMarkers()"),t.map.clearMarkers();for(var o=0;o<e.length;o++){var i=e[o],n=new google.maps.LatLng(i._geoloc.lat,i._geoloc.lng),r=new google.maps.Marker({position:n,url:i.permalink,headline:i._highlightResult.title.value});google.maps.event.addListener(r,"click",function(){window.location.href=this.url}),t.map.markers.push(r)}t.map.markerCluster=new MarkerClusterer(t.map.$map,t.map.markers,{minimumClusterSize:4})}},console.log("searchbox:"),console.log(t.searchbox),t.updateFilter=function(){console.log("updateFilter()"),t.map.$map.setCenter(t.map.options.center),t.map.$map.setZoom(t.map.options.zoom),t.search({global:!0}),t.map.cropMapToMarkers()},t.search=function(){console.log("search()"),o.search(t.searchbox.query,function(e,o){e&&t.searchbox.query==o.query&&($("html, body").animate({scrollTop:$("#stickyPlaceholder").offset().top},"slow"),t.hits=o.hits,t.listings=[],t.searchbox.page=1,t.paginate(),t.map.redrawMarkers(t.hits),t.hitCount=o.nbHits,t.$apply())},{hitsPerPage:2500,attributesToRetrieve:["listing_id","attra_id","permalink","_geoloc"],attributesToHighlight:["title","address"],insideBoundingBox:t.searchbox.bounds(),facets:"*",facetFilters:""})},t.paginate=function(){console.log("paginate()");var e=10,o=(t.searchbox.page-1)*e,i=o+e;t.listings.push.apply(t.listings,t.hits.slice(o,i)),t.searchbox.page++},google.maps.event.addDomListener(window,"load",t.map.initialize),google.maps.event.addDomListener(window,"resize",function(){var e=t.map.$map.getCenter();google.maps.event.trigger(t.map.$map,"resize"),t.map.$map.setCenter(e)})});$(document).ready(function(){var t=$("#stickyHeader"),e=$("#stickyPlaceholder"),o=t.offset().top;$(window).scroll(function(){$(window).scrollTop()>o?(e.height(t.height()),t.addClass("sticky"),e.addClass("sticky")):(t.removeClass("sticky"),e.removeClass("sticky"))})});