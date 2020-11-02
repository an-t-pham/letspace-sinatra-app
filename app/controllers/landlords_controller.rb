class LandlordsController < ApplicationController

  get "/login" do
    erb :login
  end

  post "/login" do
    landlord = Landlord.find_by(email: params[:email])
    if landlord && landlord.authenticate(params[:password])
       session[:landlord_id] = landlord.id
       redirect "/landlords/#{landlord.id}"
    else
      redirect "/login"
    end
  end

  get "/landlords/:id" do
    "landlords show page!"
  end
end