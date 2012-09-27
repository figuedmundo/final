var UMSS = {
    map : null,
    infowindow : null,
    markers : Array(),
    marker : null,
    targetMarker : null,
    startPointMarker : null,
    // polyline : null,
    ruta : [],
    locations : null,
    // overlay: null,
    coord : null,
    infobox : null,

    
    init : function( opt_ ) {
        var opt = opt_ || {};
        var options = {
           zoom: opt.zoom || 16,
           center: new google.maps.LatLng(  (opt.lat || -17.3937285 ) , (opt.lng ||  -66.1457475) ),
           mapTypeId: google.maps.MapTypeId.ROADMAP    ,
           disableDefaultUI: true,
           navigationControl: true,
           mapTypeControl: true,
           mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.DEFAULT,
            mapTypeIds: [ google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.SATELLITE ]
           }
       };
       
       this.map = new google.maps.Map( $(opt.selector || "#map").get(0), options ); 


    },

    addMarker_ : function( object_ ){
                

            if (!UMSS.marker){
              UMSS.marker = new google.maps.Marker();
            };

            UMSS.marker.setPosition(new google.maps.LatLng(object_.lat, object_.lng));
            UMSS.marker.setMap(UMSS.map);
            
            // maneja el click sobre un marker y muestra el InfoWindow
            google.maps.event.addListener( UMSS.marker, 'click' , function() {
                
                if (!UMSS.infowindow) {
                    UMSS.infowindow = new google.maps.InfoWindow();
                };

                UMSS.infowindow.open(UMSS.map, marker);
            });

            // this.polyline.getPath().push( marker.position );
    },

    addMarker : function( object ){
      
      var image = new google.maps.MarkerImage('../../assets/gota.png' );

      if (!UMSS.marker){
        UMSS.marker = new google.maps.Marker({
          icon: image,
          map: UMSS.map
        });
      };
      UMSS.marker.setPosition(new google.maps.LatLng(object.lat, object.lng));
    },



    addInfobox : function(object, marker){
      var boxText = document.createElement("div");
      ibHtml =  "<div id='infobox' >"
      ibHtml +=   "<div class='ib-left'>"
      ibHtml +=     "<a href='places/"+object.id+"'><h4>"+object.name+"</h4></a> "
      if(object.telf !== undefined){
        ibHtml +=   "<p>telf: "+object.telf+"</p>"
      }
      if(object.desc !== undefined){
        ibHtml +=   "<p>"+object.desc+"</p>"
      }
      if(object.address !== undefined){
        ibHtml +=   "<p>"+object.address+"</p>"
      }
      ibHtml +=   "</div>"
      if(object.photos !== undefined){
        ibHtml +=   "<div class='ib-right'>"
        ibHtml +=     "<img src="+object.photos[0].url+">"
        ibHtml +=   "</div>"
      }
      ibHtml += "</div>"

      boxText.innerHTML = ibHtml

      var myOptions = {
               // content: boxText
              disableAutoPan: false
              ,maxWidth: 0
              ,pixelOffset: new google.maps.Size(0, 0)
              ,zIndex: null
              ,boxStyle: { 
                // background: "url('tipbox.gif') no-repeat"
                opacity: 0.90
                ,width: "270px"
               }
              ,closeBoxMargin: "1px 1px 1px 1px"
              ,closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
              ,infoBoxClearance: new google.maps.Size(1, 1)
              ,isHidden: false
              ,pane: "floatPane"
              ,enableEventPropagation: false
      };
       if (!UMSS.infobox) {
          UMSS.infobox = new InfoBox(myOptions);
      };
      UMSS.infobox.setContent(boxText);
      UMSS.infobox.open(UMSS.map, marker);
    },



    addMarkers : function( object, imageType ){
            console.log(object);

            var image = null
            if(imageType !== undefined){
              image = new google.maps.MarkerImage('../../assets/'+imageType+'.png', 
                                                  null,
                                                  null, 
                                                  new google.maps.Point(5,5), 
                                                  new google.maps.Size(10,10));

            }
            
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng( object.lat, object.lng  ),
                map: UMSS.map,
                icon: image,
                zIndex: 1
            });
            UMSS.markers.push(marker);
            
            // maneja el click sobre un marker y muestra el InfoWindow
            google.maps.event.addListener( marker, 'click' , function() {
                UMSS.addInfobox(object, marker);
            });

    },

    addTargetMarker : function(object){
      // console.log(object)
      var type = 'rojo'
      var image = new google.maps.MarkerImage('../../assets/'+type+'.png', 
                                            null,
                                            null, 
                                            new google.maps.Point(6,6), 
                                            new google.maps.Size(12,12));
      if (!UMSS.targetMarker){
        UMSS.targetMarker = new google.maps.Marker();
      };
      UMSS.targetMarker.setIcon(image);
      UMSS.targetMarker.setPosition(new google.maps.LatLng(object.lat, object.lng));
      UMSS.targetMarker.setMap(UMSS.map)

      // maneja el click sobre un marker y muestra el InfoWindow
      google.maps.event.addListener( UMSS.targetMarker, 'click' , function() {
          UMSS.addInfobox(object, UMSS.targetMarker);
      });

    },

    offTargetMarker : function(){
      console.log(UMSS.targetMarker);
      UMSS.infobox.close();
      // UMSS.targetMarker.setMap(null);
      // UMSS.targetMarker.setMap(UMSS.map);

    },

    addMarkers_ : function(locations){
         // this.locations = locationsJSON.locations;
         console.log(locations);
          $.each( locations, function( key, value ) {
              UMSS.addMarkers(value, 'rojo');

          });
          // UMSS.showMarkers();
    },

    getCoords : function() {
      
      google.maps.event.addListener(this.map, 'click', function(event){
        // var c = null;
      //   var x, y, coord
      //   x = event.latLng.lat();
      //   y = event.latLng.lng();

      //   coord = { lat: x, lng: y }
      //   // return coord
      //   alert(coord)
         UMSS.coord = { lat: event.latLng.lat() , lng: event.latLng.lng() }
        // UMSS.coord = { lat: '1', lng: 3 };
      });
        return UMSS.coord
    },

    removeMarkers : function() {
        this.markers.length = 0;
    },

/*    addMarkers : function(){
         this.locations = locationsJSON.locations;
         console.log(this.locations);
          $.each( this.locations, function( key, value ) {
              mapa.addMarker(value);
          });
          mapa.showMarkers();
    },*/
    showMarkers : function(){
        $.each(this.markers, function(key, value) {
            // console.log(value);
            value.setMap(UMSS.map);
        });
    },

    hideMarkers : function(){
         $.each(this.markers, function(key, value) {
            value.setMap(null);
        });
    },

    addPolyline : function(list_) {
      $.each(list_, function(key, value){
        way = new google.maps.MVCArray()
        $.each(value, function(key, p){
          latLon = new google.maps.LatLng( p.lat, p.lon  )
          way.push(latLon)
        });
        UMSS.setPolyline(way)
      });
    },

    setPolyline : function(way) {
      polyline = new google.maps.Polyline({
        path: way,
        strokeColor: "#ff0000",
        strokeOpacity: 0.6,
        strokeWeight: 2
      });
      UMSS.ruta.push(polyline)
      polyline.setMap(UMSS.map);
    },

    // addPolyline : function(array_){
    //   $.each(array_, function(value) {
    //     UMSS.polyline.getPath().push( value );
    //   });
    //   UMSS.showPolyline();
    // },

    showPolyline : function(){
      $.each(UMSS.ruta, function(k, p){
        p.setMap(UMSS.map);
      });   


    },

    hidePolyline : function(){
        // UMSS.polyline.setMap(null);
      $.each(UMSS.ruta, function(k, p){
        p.setMap(null);
        // console.log(p)
      });   
    },

    addOverlay : function ( bounds , image ){
        var overlay = new UMSSOverlay(bounds, image, this.map);
        return overlay;
    }

}

function UMSSOverlay(bounds, image, map) {
// console.log(map);
    // google.maps.OverlayView.call(this);
  // Now initialize all properties.
  this.bounds_ = bounds;
  this.image_ = image;
  this.map_ = map;

  // We define a property to hold the image's
  // div. We'll actually create this div
  // upon receipt of the add() method so we'll
  // leave it null for now.
  this.div_ = null;

  // Explicitly call setMap() on this overlay
  this.setMap(map);
}

UMSSOverlay.prototype  =  new google.maps.OverlayView(); 



UMSSOverlay.prototype.onAdd = function() {
        // Create the DIV and set some basic attributes.
        var div = document.createElement('div');
        div.style.border = "none";
        div.style.borderWidth = "0px";
        div.style.position = "absolute";

        // Create an IMG element and attach it to the DIV.
        var img = document.createElement("img");
        img.src = this.image_;
        img.style.width = "100%";
        img.style.height = "100%";
        div.appendChild(img);
        
        // Set the overlay's div_ property to this DIV
        this.div_ = div;

        // We add an overlay to a map via one of the map's panes.
        // We'll add this overlay to the overlayImage pane.
        var panes = this.getPanes();
        panes.overlayLayer.appendChild(div);
        
    };

UMSSOverlay.prototype.draw =  function() {
        // Size and position the overlay. We use a southwest and northeast
        // position of the overlay to peg it to the correct position and size.
        // We need to retrieve the projection from this overlay to do this.
        var overlayProjection = this.getProjection();

        // Retrieve the southwest and northeast coordinates of this overlay
        // in latlngs and convert them to pixels coordinates.
        // We'll use these coordinates to resize the DIV.
        var sw = overlayProjection.fromLatLngToDivPixel(this.bounds_.getSouthWest());
        var ne = overlayProjection.fromLatLngToDivPixel(this.bounds_.getNorthEast());

        // Resize the image's DIV to fit the indicated dimensions.
        var div = this.div_;
        div.style.left = sw.x + 'px';
        div.style.top = ne.y + 'px';
        div.style.width = (ne.x - sw.x) + 'px';
        div.style.height = (sw.y - ne.y) + 'px';
};

UMSSOverlay.prototype.onRemove = function() {
  this.div_.parentNode.removeChild(this.div_);
  this.div_ = null;
};

UMSSOverlay.prototype.opacity = function( opacity_ ){
    /*
     if (typeof(this.div_.style.filter) =='string'){
       this.div_.style.filter = 'alpha(opacity:' + opacity + ')' ;
      }

   */
/*      var x = opacity/100 ;
      console.log( $(this.div_) );

      if (typeof(this.div_.style.KHTMLOpacity) == 'string' ){
       this.div_.style.KHTMLOpacity = x ;
      };
      if (typeof(this.div_.style.MozOpacity) == 'string'){
       this.div_.style.MozOpacity = x ;
      };
      if (typeof(this.div_.style.opacity) == 'string'){
       this.div_.style.opacity = x ;
      }; 
*/
      $(this.div_).css({ opacity: opacity_ })
};


function infoWC (title) {
  
}
  
  var infowindowContent = document.createElement('div');
  // infowindow.setAttribute('id', 'infowindow');

  var p = document.createElement('p');
  p.innerHTML = 'hola mundo '; 

  infowindowContent.appendChild(p);



/*
$(document).ready(function(){
    UMSS.init();


        var swBound = new google.maps.LatLng( 
         -17.395639841287075, -66.1495984815931
        );

        var neBound = new google.maps.LatLng(
          -17.391806900392517, -66.14190523558614
        );
        var bounds = new google.maps.LatLngBounds(swBound, neBound);

        var srcImage = 'imagenes/umss3.png';


        // var primerPiso  = UMSSOverlay( bounds, srcImage, UMSS.map );
        var primerPiso  = UMSS.addOverlay( bounds, srcImage );
        console.log(primerPiso);

        // var segundoPiso = UMSSOverlay( bounds, "imagenes/margen1.png", UMSS.map)
        var segundoPiso = UMSS.addOverlay( bounds, "imagenes/margen1.png")
        console.log(segundoPiso.div_);
        // segundoPiso.setO(50);

        $('#primer-piso').click(function(){
            ($(this).prop('checked')) ?  primerPiso.opacity(1) : primerPiso.opacity(0) ;
        });
        $('#segundo-piso').click(function(){
            ($(this).prop('checked')) ?  segundoPiso.opacity(1) : segundoPiso.opacity(0) ;
        });

});
*/
// var primerPiso = new UMSS.UMSSOverlay();

