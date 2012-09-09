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
    UMSS.showMarkers()


  
  $('#finder_place #query_places').click ->
    target_coord = $('input[name="place"]:checked').val()
    $('#lon_t').val target_coord.split(" ")[0]
    $('#lat_t').val(target_coord.split(" ")[1])

  $('#finder_place #buscar_ruta').click ->
    if $('#lon_s').val() == "" and $('#lon_t').val() == ""
      return false
    

# if gon?
  # if gon.poly?
  #   poly = gon.poly
  #   UMSS.addPolyline poly
  
  if gon.places?
    places = gon.places
    console.log places
    UMSS.addMarkers_(places)

  if gon.place?
    UMSS.addMarkers(gon.place)
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
  