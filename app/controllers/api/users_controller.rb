class Api::UsersController < ApplicationController
  include Swagger::Blocks

  before_action :find_user, only: [:show, :update, :destroy]

  swagger_path '/users' do
    operation :get do
      key :description, 'Returns all users from the system'
      key :operationId, 'findUsers'
      key :produces, %w(application/json)
      key :tags, [
        'user'
      ]
      parameter do
        key :name, :limit
        key :in, :query
        key :description, 'maximum number of results to return'
        key :required, false
        key :type, :integer
        key :format, :int32
      end
      response 200 do
        key :description, 'user response'
        schema do
          key :type, :array
          items do
            key :'$ref', :User
          end
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
    operation :post do
      key :description, 'Creates a new user'
      key :operationId, 'addUser'
      key :produces, %w(application/json)
      key :tags, %w(user)
      parameter do
        key :name, :user
        key :in, :body
        key :description, 'User to add'
        key :required, true
        schema do
          key :'$ref', :UserInput
        end
      end
      response 200 do
        key :description, 'user response'
        schema do
          key :'$ref', :User
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end

  swagger_path '/user/{id}' do
    operation :get do
      key :description, 'Returns a single user'
      key :operationId, 'findUserById'
      key :tags, %w(user)
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of user to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'user response'
        schema do
          key :'$ref', :User
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end

  def index
    @users = User.all

    render json: @users
  end

  def create
    User.create(user_params)
  end

  def show
    if stale?(last_modified: @user.updated_at, public: true)
      render json: @user
    end
  end

  def update
    @user.update!(user_params)
  end

  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name)
  end

end
