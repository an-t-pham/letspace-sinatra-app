require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "very_secret_session"
  end

  get "/" do
    if logged_in?
      redirect "/landlords/#{current_landlord.id}"
    else
      erb :welcome
    end
  end

  helpers do
    def current_landlord
      Landlord.find_by(id: session[:landlord_id])
    end

    def logged_in?
      !!current_landlord
    end
  end

end
