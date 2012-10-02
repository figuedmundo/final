# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  # $('').pjax('[data-pjax-container]')
  # $('#new_place') ->
    # new NewPlace()

  # $('#show_place')
  #   new ShowPlace()

  UMSS.init();
  new Slider()


  $('#new_place #map').click ->
    coords = UMSS.getCoords()
    $('#place_lat').val(coords.lat)
    $('#place_lon').val(coords.lng)
    UMSS.addMarker(coords)
    UMSS.showMarkers()
      # alert 'hola'
  

  $('#finder_place #map').click ->
    coords = UMSS.getCoords()
    $('#lon_s').val(coords.lng)
    $('#lat_s').val(coords.lat)
    UMSS.addMarker(coords)

  $('#query_places').on 'click', 'input', ->
    place = $(this).data('place')
    console.log place
    $('#lat_t').val place.lat
    $('#lon_t').val place.lng
    UMSS.addTargetMarker(place)
    UMSS.infobox.close()
    # UMSS.offTargetMarker()



  $('#finder_place #buscar_ruta').click ->
    if( $('#lon_s').val() == "" or $('#lon_t').val() == "" )
      return false
    

# if gon?
  # if gon.poly?
  #   poly = gon.poly
  #   UMSS.addPolyline poly
  
  if gon.places?
    places = gon.places
    console.log places
    UMSS.addMarkers_(places, 'rojo')

  if gon.place?
    UMSS.addMarker(gon.place, 'blue')
    UMSS.showMarkers()
###  
###
  
###
###

  # google.maps.event.addListener(UMSS.map, 'click', function(event)
  #   alert event.latLng
  # 

class Slider
  constructor: ->
    $('#slider').nivoSlider({
        effect: 'fade'
        pauseTime: 5000
        # directionNav: false
        controlNav: false
      })

class NewPlace
  constructor: ->
    # $('#new_place')
    alert 'new place'

class ShowPlace
  constructor: ->
    alert 'show place'
  