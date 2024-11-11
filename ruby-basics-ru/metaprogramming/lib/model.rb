# frozen_string_literal: true

# BEGIN
require 'date'

module Model

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attribute(name, options = {})
      @object_attributes ||= {}
      @object_attributes[name] = options

      define_method name do
        value = self.instance_variable_get "@#{name}"
        value.nil? ? nil : normalize_value_by_type(value, options[:type])
      end
      define_method "#{name}=" do |value|
        self.instance_variable_set "@#{name}", value
      end
    end

    def object_attributes
      @object_attributes
    end
  end

  def initialize(hash_values = {})
    object_data = self.class.object_attributes
    object_data.each do |name, options|
      if hash_values.key?(name)
        send("#{name}=", hash_values[name])
      elsif !hash_values.key?(name) && !options[:default].nil?
        send("#{name}=", options[:default])
      else
        send("#{name}=", nil)
      end
    end
  end

  def attributes
    object_data = self.class.object_attributes
    result = {}
    self.instance_variables.each do |variable|
      key = variable.to_s.gsub('@','').to_sym
      value = self.instance_variable_get(variable)
      result[key] = normalize_value_by_type(value, object_data[key][:type])
    end
    result
  end

  private

  def normalize_value_by_type(value, type)
    if type == :datetime
      normalize = value if value.respond_to?(:strftime)
      normalize = DateTime.parse(value) if value.is_a?(String)
    end
    if type == :string
      normalize = value.to_s
    end
    if type == :integer
      normalize = value.is_a?(Integer) ? value : nil
    end
    if type == :boolean
      normalize = [true, false].include?(value) ? value : nil
    end
    normalize
  end

end
# END
