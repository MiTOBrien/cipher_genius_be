class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  before_action :authenticate_user!, except: [:create, :new]
  respond_to :json
end
