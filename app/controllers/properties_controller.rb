class PropertiesController < ApplicationController

    get '/properties' do
        @properties = Property.all
        @tenant = Tenant.find(session[:tenant_id])
       erb :'properties/index'
    end

    get '/properties/:id' do
      @property = Property.find(params[:id])
      @landlord = Landlord.find(@property.landlord_id)
      erb :'properties/show'
    end

end