console.log "{gon.poly}"
console.log <%=  @path.html_safe %>

console.log <%= @costo %>

UMSS.hidePolyline()
UMSS.addPolyline <%= @path.html_safe %>


