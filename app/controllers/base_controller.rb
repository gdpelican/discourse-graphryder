module Graphryder
  class BaseController < ApplicationController

    def show
      render json: { model.graph_name => model.fetch(id) }
    end

    def count
      render json: { count: model.count }
    end

    def count_by_author
      render json: { count: model.count_by_author }
    end

    private

    def model
      "::Graphryder::#{controller_name.demodulize.singularize.humanize}".constantize.instance
    end
  end
end
