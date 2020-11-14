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
       flash[:message] = "Welcome back #{landlord.name}!"
       redirect "/landlords/#{landlord.id}"
    else
      flash[:error] = "Your email or password were invalid. Please try again!"
      redirect "/landlords/login"
    end
  end

  get "/landlords/logout" do
    if landlord_logged_in? 
      session.clear
      redirect "/"
    else
      flash[:error] = "You're not logged in!"
      redirect "landlords/login"
    end
  end

  get "/landlords/signup" do
    erb :"/landlords/signup"
  end

  post "/landlords" do
    @landlord = Landlord.new(params)
    if @landlord.save
       session[:landlord_id] = @landlord.id
       flash[:message] = "Account successfully created!"
       redirect "/landlords/#{@landlord.id}"
    else
       flash[:error] = "Account creation failed: #{@landlord.errors.full_messages.to_sentence}"
       redirect "/landlords/signup"
    end
  end


  get "/landlords/properties" do
    if landlord_logged_in?
      @landlord = Landlord.find(session[:landlord_id])
      erb :"landlords/properties"
    else
      flash[:error] = "Please log in to see properties!"
      redirect "landlords/login"
    end
  end

  post "/landlords/properties" do
    if landlord_logged_in?
      @property = Property.create(params)
      @property.landlord_id = session[:landlord_id]
      if @property.save
        flash[:message] = "Property successfully created!"
        redirect "/landlords/properties"
      else
       flash[:error] = "Property creation failed: #{@property.errors.full_messages.to_sentence}"
       redirect "/landlords/properties/new"
      end
    end
    

  end

  get "/landlords/properties/new" do
    if landlord_logged_in?
      @tenants = Tenant.all
      erb :"landlords/properties_new"
    else
      flash[:error] = "Please log in to add new property!"
      redirect "landlords/login"
    end
  end

  get "/landlords/tenants" do
    if landlord_logged_in?
      @landlord = Landlord.find(session[:landlord_id])
        @current_tenants = @landlord.properties.collect do |property| 
          property.tenants
        end
        @current_tenants.flatten!                   
        erb :"landlords/tenants"
    else
      flash[:error] = "Please log in! to see your tenants"
      redirect "landlords/login"
    end
  end

  get "/landlords/properties/:property_id" do
    if landlord_logged_in?
       @property = Property.find(params[:property_id])
       if authorized_to_edit?(@property)
         @tenants = @property.tenants
         erb :"/landlords/properties_view"
        else 
          @landlord = Landlord.find(session[:landlord_id])
          flash[:error] = "Not authorized to access this property!"
          redirect "landlords/#{@landlord.id}"
        end
    else
        flash[:error] = "Please log in to access your own properties!"
        redirect "landlords/login"
    end
  end

  get "/landlords/properties/:property_id/edit" do
    if landlord_logged_in? 
      @property = Property.find(params[:property_id])
      @landlord = Landlord.find(session[:landlord_id])
      if authorized_to_edit?(@property)
        @tenants = Tenant.all
        @current_tenants = @property.tenants
        erb :"landlords/properties_edit"
      else
        flash[:error] = "Not authorized to edit this property!"
        redirect "landlords/#{@landlord.id}"
      end
    else
      flash[:error] = "Please log in!"
      redirect "landlords/login"
    end
  end

  patch "/landlords/properties/:property_id" do
    if landlord_logged_in?
      @property = Property.find(params[:property_id])
      if authorized_to_edit?(@property)
         @property.update(params[:property])
         @property.save
         redirect "/landlords/properties/#{@property.id}"
      else 
        @landlord = Landlord.find(session[:landlord_id])
        flash[:error] = "Not authorized to edit this property!"
        redirect "landlords/#{@landlord.id}"
      end

    else
      flash[:error] = "Please log in!"
      redirect "landlords/login"
    end
      
  end

  delete "/landlords/properties/:property_id" do
    if landlord_logged_in?
      Property.destroy(params[:property_id])
    end
    redirect to "/landlords/properties"
    
  end


  get "/landlords/:id" do
    if landlord_logged_in? 
      @landlord = Landlord.find_by(id: params[:id])
      if landlord_authorized?(@landlord)
         erb :"/landlords/show"
      else
        @landlord = Landlord.find(session[:landlord_id])
        flash[:error] = "Not authorized to access this profile!"
        redirect "landlords/#{@landlord.id}"
      end
    else
      flash[:error] = "Please log in to access your account!"
      redirect "landlords/login"
    end
  end

  get "/landlords/:id/edit" do
    if landlord_logged_in?
      @landlord = Landlord.find(params[:id])
      if landlord_authorized?(@landlord)
        erb :"/landlords/edit"
      else
        @landlord = Landlord.find(session[:landlord_id])
        flash[:error] = "Not authorized to edit this profile!"
        redirect "landlords/#{@landlord.id}"
      end
    else
      flash[:error] = "Please log in!"
      redirect "landlords/login"
    end
  end

  patch "/landlords/:id" do
    if landlord_logged_in?
      @landlord = Landlord.find(params[:id])
      if landlord_authorized?(@landlord)
        @landlord.update(params[:landlord])
        redirect "/landlords/#{@landlord.id}"
      else
        @landlord = Landlord.find(session[:landlord_id])
        flash[:error] = "Not authorized to edit this profile!"
        redirect "landlords/#{@landlord.id}"
      end
    else
      flash[:error] = "Please log in!"
      redirect "landlords/login"
    end
  end

  delete "/landlords/:id" do
    if landlord_logged_in? && session[:landlord_id].to_s == params[:id]
      Landlord.destroy(params[:id])
      flash[:message] = "Account successfully deleted"
      redirect to "/"
    else
      flash[:error] = "Please log in!"
      redirect "landlords/login"
    end
  end

  
end