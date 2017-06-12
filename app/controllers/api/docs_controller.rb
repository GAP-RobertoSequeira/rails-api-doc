 class Api::DocsController < ApplicationController
    include Swagger::Blocks

    swagger_root do
      key :swagger, '2.0'
      info do
        key :version, '1.0.0'
        key :title, 'Rails API Docs example'
        key :description, 'A sample API to demonstrate features in the swagger-2.0 specification'
      end
      tag do
        key :name, 'user'
        key :description, 'Users operations'
        externalDocs do
          key :description, 'Find more info here'
          key :url, 'https://swagger.io'
        end
      end
      key :host, 'https://rails-api-docs.herokuapp.com/'
      key :basePath, '/api'
      key :consumes, ['application/json']
      key :produces, ['application/json']
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
      UsersController,
      User,
      self,
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
