$('#query_places').html('<%= escape_javascript(render(partial: 'query_places', collection: @places, as: :place)) %>')
