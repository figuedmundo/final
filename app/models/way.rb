# == Schema Information
#
# Table name: ways
#
#  gid        :integer         not null, primary key
#  name       :string(255)
#  dist       :float
#  source     :integer
#  target     :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  the_geom   :spatial({:srid=
#
# require "rgeo-shapefile"

class Way < ActiveRecord::Base
  attr_accessible :dist, :name, :the_geom

  FACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column(:the_geom, FACTORY.projection_factory)


  def self.add_vertices
    connection = Way.connection
    connection.exec_query("SELECT assign_vertex_id('ways', 0.001, 'the_geom', 'gid');")
    Way.clear_active_connections!
  end

  def self.path_cost_from(lon_s, lat_s, lon_t, lat_t)
    point_source = FACTORY.point(lon_s, lat_s).projection
    point_target = FACTORY.point(lon_t, lat_t).projection
    connection = Way.connection
    s = connection.select_value("select find_nearest_node_within_distance( '#{point_source.to_s}' , 100.0, 'ways' )")
    t = connection.select_value("select find_nearest_node_within_distance( '#{point_target.to_s}' , 100.0, 'ways' )")
    res = connection.select_all("SELECT  * from  shortest_path('select gid as id, source::integer, 
                                target::integer, dist::double precision as cost from ways', 
                                #{s.to_i}, #{t.to_i}, false, false)")
    Way.clear_active_connections!

    get_edges_cost res
  end

  def self.get_way(edges)
    path = []
    
    edges.each do |edge|
      lonLat = []
      if edge > 0
        way = Way.find(edge)
        # lonLat << points_to_json(unproject_points(way.the_geom.points))
        way.the_geom.points.each do |point|
          unprojected_point = FACTORY.unproject(point) 
          lonLat << { lon: unprojected_point.x, lat: unprojected_point.y }
        end
      end
      path << lonLat
    end
    path
  end

  def self.hot_spots(edges)
    # edges.pop    
    where = "where "
    edges.each_with_index do |edge, i|
      if edge > 0
        where += "w.gid = #{edge}" 
        where += " or " unless i == edges.length - 2
      end
    end


    connection = Way.connection
    places = connection.select_all("select distinct on (p.id) p.id 
                                   from places p left join ways w  on st_dwithin(p.coord, w.the_geom, 20) 
                                   #{where}")
    Way.clear_active_connections!

    places.map { |place| place["id"].to_i }

  end

  def self.load_shapefile(path)
    RGeo::Shapefile::Reader.open( path, factory: FACTORY ) do |file|
      file.each do |record|
        way = record.geometry.projection
        ruta = Way.create( name: record['id'], dist: way.length, the_geom: way[0]  )
        # ruta.the_geom = way
        # ruta.save
      end
    end
  end

  private

    def self.get_edges_cost(lista)
      edges = []
      costo = 0
      lista.each do |l|
        edges << l["edge_id"].to_i
        costo += l["cost"].to_i
      end
      { edges: edges, cost: costo }
    end

end

# RGeo::Shapefile::Reader.open('../../garmin/casa/borde_casa.shp') do |file|
#   puts "File contains #{file.num_records} records."
#   file.each do |record|
#     puts "Record number #{record.index}:"
#     puts "  Geometry: #{record.geometry.as_text}"
#     puts "  Attributes: #{record.attributes.inspect}"
#   end
#   file.rewind
#   record = file.next
#   puts "First record geometry was: #{record.geometry.as_text}"
# end


 # $ irb
 # > require 'rgeo'
 #  => true
 # > require 'rgeo-shapefile'
 #  => true
 # > require File.expand_path('config/environment', '.')
 #  => true
 # >  Way.load_shapefile('public/umss/umss')



  # def load_shapefile(path)
  #   RGeo::Shapefile::Reader.open( path, factory: FACTORY ) do |file|
  #     file.each do |record|
  #       puts "Record number #{record.index}:"
  #       puts "  Geometry: #{record.geometry.as_text}"
  #       puts "  id : #{record['id']}"
  #     end
  #   end
  # end