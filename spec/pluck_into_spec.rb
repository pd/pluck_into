require 'spec_helper'
require 'ostruct'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define(version: 1) do
  create_table :widgets do |t|
    t.text    :name
    t.integer :size
  end
end

class Widget < ActiveRecord::Base
end

describe PluckInto do
  before(:context) do
    [ {name: 'knob', size: 10},
      {name: 'handle', size: 100},
      {name: 'doodad', size: 1}
    ].each { |attrs| Widget.create!(attrs) }
  end

  it "instantiates the given object type with a single hash argument" do
    klass = Class.new do
      attr_reader :arg
      def initialize(arg)
        @arg = arg
      end
    end

    results = Widget.where(name: 'knob').pluck_into(klass, :name, :size)
    expect(results.first.arg).to eq(name: 'knob', size: 10)
  end

  it "handles an empty result set" do
    results = Widget.where(name: 'nope').pluck_into(OpenStruct, :id, :size)
    expect(results).to be_empty
  end

  it "can be called directly on the class" do
    results = Widget.pluck_into(OpenStruct, :name, :size)
    expect(results.map(&:name)).to contain_exactly('knob', 'handle', 'doodad')
    expect(results.map(&:size)).to contain_exactly(1, 10, 100)
  end

  it "can be called on scopes" do
    results = Widget.where('size > ?', 50).pluck_into(OpenStruct, :name)
    expect(results.map(&:name)).to eq(['handle'])
  end
end
