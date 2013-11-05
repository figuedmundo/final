console.log "{gon.poly}"
console.log <%=  @path.html_safe %>

console.log <%= @costo %>
console.log <%=raw @hot_spots %>

UMSS.hidePolyline()
UMSS.hideMarkers()

UMSS.addPolyline <%= @path.html_safe %>

<% @hot_spots.each do |hs| %>
UMSS.addMarkers(<%= hs.html_safe %>, 'azul')
<% end %>
UMSS.targetMarker.setZIndex(google.maps.MAX_ZINDEX)

$('#solution').
  html(" La distancia aproximada al destino es de " + <%= @costo %> + " mts").
  show()

