class LandlordsController < ApplicationController

  get "/landlords/welcome" do
    erb :"/landlords/welcome"
  end

  get "/landlords/login" do
    erb :"/landlords/login"
  end

  post "/landlords/login" do
    landlord = Landlord.find_by(email: params[:email])
    if landlord && landlord.authenticate(params[:password])
       session[:landlord_id] = landlord.id
       redirect "/landlords/#{landlord.id}"
    else
      redirect "/landlords/login"
    end
  end

  get "/landlords/signup" do
    erb :"/landlords/signup"
  end

  post "/landlords" do
    @landlord = Landlord.create(params)

    session[:landlord_id] = @landlord.id

    redirect "/landlords/#{@landlord.id}"
  end


  get "/landlords/properties" do
    @landlord = Landlord.find(session[:landlord_id])
      if @landlord 
        erb :"landlords/properties"
      else
        redirect "/login"
      end
  end

  post "/landlords/properties" do
    @property = Property.create(params)
    @property.landlord_id = session[:landlord_id]
    @property.save
    redirect "/landlords/properties"
  end

  get "/landlords/properties/new" do
    @tenants = Tenant.all
    erb :"landlords/properties_new"
  end

  get "/landlords/tenants" do
    @landlord = Landlord.find(session[:landlord_id])
    if @landlord
      @current_tenants = @landlord.properties.collect do |property| 
        property.tenants.filter {|tenant| property.id == tenant.current_property_id}
      end
      @current_tenants.flatten!
                               
      erb :"landlords/tenants"
    else
      redirect "/login"
    end
  end

  get "/landlords/properties/:property_id" do
     @property = Property.find(params[:property_id])
     @tenants = @property.tenants.filter {|tenant| @property.id == tenant.current_property_id}
     @previous_tenants = @property.tenants.filter {|tenant| @property.id != tenant.current_property_id}

     erb :"/landlords/properties_view"
  end

  get "/landlords/properties/:property_id/edit" do
    @property = Property.find(params[:property_id])
    @tenants = Tenant.all
    @current_tenants = @property.tenants.filter {|tenant| @property.id == tenant.current_property_id}
    erb :"landlords/properties_edit"
  end

  patch "/landlords/properties/:property_id" do
    @property = Property.find(params[:property_id])
    @property.update(params[:property])
    redirect "/landlords/properties/#{@property.id}"
  end

  delete "/landlords/properties/:property_id" do
    @property = Property.find(params[:property_id])
    @current_tenants = @property.tenants.filter {|tenant| @property.id == tenant.current_property_id}
    @current_tenants.each do |tenant|
      tenant.current_property_id = nil
      tenant.save
    end
   
    Property.destroy(params[:property_id])
    redirect to "/landlords/properties"
  end


  get "/landlords/:id" do
    @landlord = Landlord.find_by(id: params[:id])
    erb :"/landlords/show"
  end

  get "/landlords/:id/edit" do
    erb :"/landlords/edit"
  end


  get "/logout" do
    session.clear
    redirect "/"
  end
end