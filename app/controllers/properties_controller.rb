class PropertiesController < ApplicationController

    get '/properties' do
        @properties = Property.all
       erb :'properties/index'
    end

    get '/properties/:id' do
      @property = Property.find(params[:id])

      erb :'properties/show'
    end
end