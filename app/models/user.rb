class User < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :User do
    key :required, [:username, :first_name, :last_name]
    property :username do
      key :type, :string
    end
    property :first_name do
      key :type, :string
    end
    property :last_name do
      key :type, :string
    end
  end

  swagger_schema :UserInput do
    allOf do
      schema do
        key :'$ref', :User
      end

      schema do
        key :required, [:username, :first_name, :last_name]

        property :username do
          key :type, :string
        end
        property :first_name do
          key :type, :string
        end
        property :last_name do
          key :type, :string
        end
      end
    end
  end

end
