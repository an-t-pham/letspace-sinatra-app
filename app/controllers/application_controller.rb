require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "very_secret_session"
    register Sinatra::Flash
  end

  get "/" do
    if landlord_logged_in?
      redirect "/landlords/#{current_landlord.id}"
    else
      erb :welcome
    end
  end

  helpers do
    def current_landlord
      Landlord.find_by(id: session[:landlord_id])
    end

    def landlord_logged_in?
      !!current_landlord
    end

    def current_tenant
      Tenant.find_by(id: session[:tenant_id])
    end

    def tenant_logged_in?
      !!current_tenant
    end

    def authorized_to_edit?(property)
      property.landlord == current_landlord
    end
  end

end
