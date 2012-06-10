# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # $('#new_place') ->
    # new NewPlace()

  # $('#show_place')
  #   new ShowPlace()

  UMSS.init();

  places = gon.places
  console.log places
###
  $('#map').click ->
    coords = UMSS.getCoords()
    $('#place_lat').val(coords.lat)
    $('#place_lng').val(coords.lng)
    UMSS.addMarker(coords)
    UMSS.showMarkers()
    # alert 'hola'

  if gon
    marker = { lat: gon.x, lng: gon.y, info: gon.place_info }
    UMSS.addMarkers(marker)
    UMSS.showMarkers()
###

  # google.maps.event.addListener(UMSS.map, 'click', function(event)
  #   alert event.latLng
  # 

class NewPlace
  constructor: ->
    # $('#new_place')
    alert 'new place'

class ShowPlace

  constructor: ->
    alert 'show place'
  