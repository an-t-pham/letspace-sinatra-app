class LandlordsController < ApplicationController

  get "/login" do
    erb :"landlords/login"
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
    @landlord = Landlord.find_by(id: params[:id])
    erb :"/landlords/show"
  end

  get "/signup" do
    erb :"/landlords/signup"
  end

  post "/landlords" do
    @landlord = Landlord.create(params)

    session[:landlord_id] = @landlord.id

    redirect "/landlords/#{@landlord.id}"
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end