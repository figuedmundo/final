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

require 'spec_helper'

describe Way do
  
  before do
    @way = Way.new( name: "nombre del camino", dist: 1.0 )
  end

  subject { @way }
  
  it { should respond_to(:gid) }
  it { should respond_to(:name) }
  it { should respond_to(:dist) }
  it { should respond_to(:the_geom) }

  it { should be_valid }
end
