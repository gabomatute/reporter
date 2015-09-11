module Tableless
  extend ActiveSupport::Concern
  # Tableless Model Requirements
  include ActiveModel::Model
  include ActiveModel::Serialization

  # == ALERT ==
  # ActiveModel::Serialization method serializable_hash requires a method
  # attributes that returns a hash with keys for methods to serialize

  # Methods defined here are going to extend the class, not the instance of it
  module ClassMethods
    # Sets an standard initializer for the class, similar to ActiveRecord's
    def initialize(attribs = {})
      attribs.each do |name, value|
        send("#{name}=", value)
      end
    end

    # Creates an alias to define 'columns' for the model
    def column (attrib)
      attr_accessor attrib
    end

    # Simulates ActiveRecord's belongs_to setting some methods for the model
    def belongs_to (model)
      # First create methods to access the reffered model
      attr_accessor model
      # Create a getter for the model id
      define_method "#{model}_id" do
        send(model) ? send(model).id : nil
      end
      # Create a setter through the model id
      define_method "#{model}_id=" do |id|
        send("#{model}=", Object.const_get(model.to_s.camelcase).find(id))
      end
    end

    # Simulates ActiveRecord's has_many setting some methods for the model
    def has_many (model)
      # Create a setter for the child models
      attr_writer model
      # Create a custom getter for the child models
      define_method model do
        # If its not set it returns an empty array
        instance_variable_get("@#{model}") || []
      end
    end

    # Simulates ActiveRecord's accept_nested_attributes_for setting some methods for the nested model
    def accept_nested_attributes_for (model)
      # Creates a method to serialize the child objects for ActiveModel::Serialization
      define_method "#{model}_attributes" do
        send(model).map { |e| e.serializable_hash }
      end
      # Defines a method to allow the nested attributes
      define_method "#{model}_attributes=" do |collection_attribs|
        # If the collection_attribs is a Hash convert it to an array (to receive from params)
        collection_attribs = collection_attribs.values if collection_attribs.is_a? Hash
        # For each nested attribute create and add a nested model
        collection_attribs.each do |attribs|
          send("#{model}=", send(model) << Object.const_get(model.to_s.singularize.camelcase).new(attribs.merge(self.class.name.underscore.to_sym => self)))
        end
      end
    end
  end
end
