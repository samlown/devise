module Devise
  module Orm
    module CouchRest
      module Hook
        def devise_modules_hook!
          extend Schema
          #Include Compatibility
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
      end #Hook

      module Schema
        include Devise::Schema

        # Tell how to apply schema methods.
        def apply_schema(name, type, options={})
          #return unless Devise.apply_schema
          property name, :cast_as => type
        end
      end #Module Schema 

    end #CouchRest
  end #Orm
end #Devise
CouchRest::ExtendedDocument.send(:extend, Devise::Models)
CouchRest::ExtendedDocument.send(:include, Devise::Models)
