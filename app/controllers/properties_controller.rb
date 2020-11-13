class PropertiesController < ApplicationController

    get '/properties' do
       if tenant_logged_in?
          @properties = Property.all
          @tenant = Tenant.find(session[:tenant_id])
         erb :'properties/index'
       else
        flash[:error] = "Please log in or sign up to see available properties!"
        redirect "tenants/login"
       end
    end

    get '/properties/:id' do
      if tenant_logged_in?
        @property = Property.find(params[:id])
        @landlord = Landlord.find(@property.landlord_id)
        erb :'properties/show'
      else
        flash[:error] = "Please log in or sign up to see available properties!"
        redirect "tenants/login"
      end
    end

end