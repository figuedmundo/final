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
    connection.exec_query("SELECT assign_vertex_id('ways', 0.00001, 'the_geom', 'gid');")
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

=begin
p1   = factory.point( -66.14927826244207, -17.394110572053894 ).projection
p2   = factory.point( -66.14772258121343 , -17.393844378197922 ).projection
p3   = factory.point(-66.14668188411565,-17.393629375185277 ).projection
p4   = factory.point(-66.14624200183721, -17.393516754458737 ).projection
p5   = factory.point( -66.14672479945989,-17.39332222758593 ).projection
p6   = factory.point( -66.14604888278814,-17.39447914752256 ).projection

way1 = factory.projection_factory.line_string([p1,p2,p3])
way2 = factory.projection_factory.line_string([p3,p4])
way3 = factory.projection_factory.line_string([p3,p5])
way4 = factory.projection_factory.line_string([p4,p6])

ruta1 = Way.new(name: "ruta1")
ruta1.the_geom = way1
ruta1.dist = p1.distance(p2) + p2.distance(p3)
ruta1.save

ruta2 = Way.new(name: "ruta2")
ruta2.the_geom = way2
ruta2.dist = p3.distance(p4) 
ruta2.save

ruta3 = Way.new(name: "ruta3")
ruta3.the_geom = way3
ruta3.dist = p3.distance(p5) 
ruta3.save

ruta4 = Way.new(name: "ruta4")
ruta4.the_geom = way4
ruta4.dist = p4.distance(p6) 
ruta4.save
=end


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
 # >  Way.load_shapefile('path/to/shapefile')



  # def load_shapefile(path)
  #   RGeo::Shapefile::Reader.open( path, factory: FACTORY ) do |file|
  #     file.each do |record|
  #       puts "Record number #{record.index}:"
  #       puts "  Geometry: #{record.geometry.as_text}"
  #       puts "  id : #{record['id']}"
  #     end
  #   end
  # end