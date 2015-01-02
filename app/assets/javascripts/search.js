'use strict';

var app = angular.module('search', [
  'ngRoute',
  'ngSanitize',
  'infinite-scroll'
])
.config(['$routeProvider', function($routeProvider) {
  $routeProvider.otherwise({ templateUrl: 'propertySearch.html' });
}])
.config(['$locationProvider', function($locationProvider) {
  $locationProvider.html5Mode(true);
}])
.run(['$location', '$rootElement', function ($location, $rootElement) {
  $rootElement.off('click');
}])
.factory('Contacts', function() {
  return new AlgoliaSearch('4FQPTMXLRJ', 'f2f48a01e99540374fb78edeace42012').initIndex('Listing_development');
})
.controller('SearchCtrl', function ($scope, $location, Contacts) {
    $scope.hits = [];
    $scope.listings = [];
    $scope.hitCount = "__";
    $scope.paginating = false;

    // set up initial search parameters
    $scope.searchbox = {
      query:    $location.search().keywords || '',
      product:  $location.search().product  || '',
      location: $location.search().location || '',
      offering: $location.search().offering || '',
      page:     $location.search().page     || 1,
      center:   $location.search().center   || '39.3369535,-94.1065431', //$scope.map.options.center.lat() + ',' + $scope.map.options.center.lng(),
      zoom:     parseInt($location.search().zoom)     || 4,
      bounds:   function() {
        console.log("bounds()");
        // get current map bounds through JS API
        var
          NESW   = $scope.map.$map.getBounds(),
          p1     = NESW.getNorthEast(),
          p2     = NESW.getSouthWest(),
          bounds = [p1.lat(), p1.lng(), p2.lat(), p2.lng()].join(',')
        ;
        return bounds;
      },
      lat: function() {
        return parseFloat($scope.searchbox.center.split(',')[0]);
      },
      lon: function() {
        return parseFloat($scope.searchbox.center.split(',')[1]);
      }
    };

    $scope.map = {
      initializing: true,
      div: document.getElementById('map-canvas'),
      options: {
        zoom: $scope.searchbox.zoom,
        center: new google.maps.LatLng($scope.searchbox.lat(), $scope.searchbox.lon()),
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.TERRAIN
      },
      $map: null,
      markers: [],
      infoWindow: null,
      markerCluster: null,
      initialize: function() {
        console.log("initialize()");

        // called by ng-init when page is ready
        $scope.map.$map = new google.maps.Map($scope.map.div, $scope.map.options);

        // This event is fired when the map becomes idle after panning or zooming.
        google.maps.event.addListener($scope.map.$map, "idle", $scope.map.onDragOrZoom);

        // This event is fired when click on map (not marker)
        google.maps.event.addListener($scope.map.$map, "click", $scope.map.closeInfoWindow());

        // some callbacks are fired after init when we don't necessarily want to handle them right now
        setTimeout(function() {
          $scope.map.initializing = false;
        }, 5000);
      },
      cropMapToMarkers: function() {
        console.log("cropMapToMarkers()");
        var
          bounds = new google.maps.LatLngBounds()
        ;

        // loop through all markers to find new bounds
        for (var i = 0; i < $scope.map.markers.length; i++) {
          var
            marker = $scope.map.markers[i],
            latlng = marker.getPosition()
          ;

          // extend our bounds so the map shows this marker
          bounds.extend(latlng);
        }

        $scope.map.$map.setCenter(bounds.getCenter());
        $scope.map.$map.fitBounds(bounds);
      },
      onDragOrZoom: function() {
        console.log("onDragOrZoom()");

        var
          mapCanvas = $scope.map.$map,
          centerURL = mapCanvas.getCenter().toUrlValue(),  // comma-separated val
          center    = mapCanvas.getCenter(),               // actual object
          zoom      = mapCanvas.getZoom()
        ;

        // find new center of the map
        $scope.searchbox.center = centerURL;
        $scope.searchbox.zoom   = zoom;

        $location.search('center', centerURL);
        $location.search('zoom', zoom);
        $location.search('page', 1);

        // perform an updated search query
        // if they dragged the map, it should be a bounded search, not global
        $scope.search({global: false});
      },
      clearMarkers: function() {
        console.log("clearMarkers()");
        // called before updating search results
        // ensures we do not have old markers on the map

        if ($scope.map.markers) {
          for (var i = 0; i < $scope.map.markers.length; i++) {
            $scope.map.markers[i].setMap(null);
            $scope.map.markers = [];
          }
        }

        if ($scope.map.markerCluster) {
          $scope.map.markerCluster.clearMarkers();
        }
      },
      closeInfoWindow: function() {
        if($scope.map.infoWindow !== null) {
          $scope.map.infoWindow.close();
        }
      },
      redrawMarkers: function(listings) {
        console.log("redrawMarkers()");
        // update map with new search result markers

        $scope.map.clearMarkers();

        // loop through all incoming listings and create individual markers
        for (var i = 0; i < listings.length; i++) {
          var
            listing = listings[i],
            latLng  = new google.maps.LatLng(listing._geoloc["lat"], listing._geoloc["lng"]),
            marker  = new google.maps.Marker({
              position:  latLng,
              url:       listing.permalink,
              headline:  listing._highlightResult.title.value
            })
          ;

          // when click on marker, will open up info window
          google.maps.event.addListener(marker, 'click', function() {
            window.location.href = this.url;
          });

          // add marker into global marker list
          $scope.map.markers.push(marker);
        }

        // (re-)create marker cluster for map object with marker list
        $scope.map.markerCluster = new MarkerClusterer(
          $scope.map.$map,
          $scope.map.markers, {
            minimumClusterSize: 4
          }
        );
      }
    };

    console.log("searchbox:");
    console.log($scope.searchbox);

    $scope.updateFilter = function() {
      console.log("updateFilter()");
      $scope.map.$map.setCenter($scope.map.options.center);
      $scope.map.$map.setZoom($scope.map.options.zoom);

      // if we update the search filter manually, perform a global search again
      $scope.search({global: true});
      $scope.map.cropMapToMarkers();
    };

    $scope.search = function(options) {
      console.log("search()");

      Contacts.search($scope.searchbox.query, function(success, content) {

        // don't do anything if there was an error during search
        if (!success || $scope.searchbox.query != content.query) {
          return;
        }

        // scroll to top of sticky searchbox
        $("html, body").animate({ scrollTop: $('#stickyPlaceholder').offset().top }, "slow");

        // search results returned
        $scope.hits = content.hits;

        // kill existing search results (if any)
        $scope.listings = [];

        // reset pagination
        $scope.searchbox.page = 1;

        // pre-fill first set of results
        $scope.paginate();

        // show the updated markers on the map
        $scope.map.redrawMarkers($scope.hits);

        // number of matching documents
        $scope.hitCount = content.nbHits;

        // update all $scope variables
        $scope.$apply();
      },
      {
        // custom Algolia search parameters
        "hitsPerPage": 2500,
        "attributesToRetrieve": ["listing_id", "attra_id", "permalink", "_geoloc"],
        "attributesToHighlight": ["title", "address"],
        "insideBoundingBox": $scope.searchbox.bounds(),
        "facets": "*",
        "facetFilters": ""
      });
    };

    $scope.paginate = function() {
      console.log("paginate()");
      var
        perPage = 10,
        start = ($scope.searchbox.page - 1) * perPage,
        end = start + perPage
      ;

      $scope.listings.push.apply($scope.listings, $scope.hits.slice(start, end));
      $scope.searchbox.page++;
      //$location.search({"page": $scope.searchbox.page - 1});
    };

    // set up google maps events
    // wait on when google thinks it's ready to load map, instead of $ng
    google.maps.event.addDomListener(window, 'load', $scope.map.initialize);
    google.maps.event.addDomListener(window, "resize", function() {
      var center = $scope.map.$map.getCenter();
      google.maps.event.trigger($scope.map.$map, "resize");
      $scope.map.$map.setCenter(center);
    });
});


$(document).ready(function() {
  // Check the initial Poistion of the Sticky Header
  var
    $stickyHeader      = $('#stickyHeader'),
    $stickyPlaceholder = $('#stickyPlaceholder'),
    stickyThreshold    = $stickyHeader.offset().top
  ;

  $(window).scroll(function(){
    if( $(window).scrollTop() > stickyThreshold ) {
      // make sure the placeholder is the same height as a the header is/was
      $stickyPlaceholder.height($stickyHeader.height());

      // the ol' switch-a-roo
      $stickyHeader.addClass('sticky');
      $stickyPlaceholder.addClass('sticky');
    } else {
      // swap 'um back
      $stickyHeader.removeClass('sticky');
      $stickyPlaceholder.removeClass('sticky');
    }
  });
});



