require "pluck_into/version"
require "active_record"

module PluckInto
  def pluck_into(klass, *column_names)
    column_names = Array(column_names)

    pluck(*column_names).map do |values|
      attributes = Hash[column_names.zip(Array(values))]
      klass.new(attributes)
    end
  end
end

ActiveRecord::Base.extend(PluckInto)
