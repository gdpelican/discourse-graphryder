module Graphryder
  class BaseController < ActionController::Base
    protect_from_forgery with: :null_session

    def query
      render json: Graphryder::Query.instance.perform(params[:query])
    end
  end
end
