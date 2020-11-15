class TenantsController < ApplicationController

    get "/tenants/welcome" do
        erb :"/tenants/welcome"
      end
    
    get "/tenants/login" do
        erb :"/tenants/login"
    end

    post "/tenants/login" do
        tenant = Tenant.find_by(email: params[:email])
        if tenant && tenant.authenticate(params[:password])
           session[:tenant_id] = tenant.id
           flash[:message] = "Welcome back #{tenant.name}!"
           redirect "/tenants/#{tenant.id}"
        else
          flash[:error] = "Your email or password were invalid. Please try again!"
          redirect "/tenants/login"
        end
      end

    get "/tenants/signup" do
        erb :"/tenants/signup"
    end
    
    post "/tenants" do
      @tenant = Tenant.new(params)
      if @tenant.save
         session[:tenant_id] = @tenant.id
         flash[:message] = "Account successfully created!"
         redirect "/tenants/#{@tenant.id}"
    else
       flash[:error] = "Account creation failed: #{@tenant.errors.full_messages.to_sentence}"
       redirect "/tenants/signup"
    end
    end

    get "/tenants/logout" do
      if tenant_logged_in?
        session.clear
        redirect "/"
      else
        flash[:error] = "Please log in!"
        redirect "tenants/login"
      end
    end

    get "/tenants/:id" do
       if tenant_logged_in? || landlord_logged_in?
          @tenant = Tenant.find_by(id: params[:id])
          @landlord = Landlord.find_by(session[:landlord_id])
            erb :"/tenants/show"
       else
        flash[:error] = "Please log in!"
        redirect "/"
        end
      end
    
    get "/tenants/:id/edit" do
      if tenant_logged_in?
        @tenant = Tenant.find(params[:id])
        if tenant_authorized?(@tenant)
          erb :"/tenants/edit"
        else
          @tenant = Tenant.find(session[:tenant_id])
          flash[:error] = "Not authorized to edit this profile!"
          redirect "tenants/#{@tenant.id}"
        end

      else
        flash[:error] = "Please log in!"
        redirect "/tenants/login"
        end
    end
    
    patch "/tenants/:id" do
      if tenant_logged_in?
        @tenant = Tenant.find(params[:id])
        if tenant_authorized?(@tenant)
           @tenant.update(params[:tenant])
           redirect "/tenants/#{@tenant.id}"
        else
            @tenant = Tenant.find(session[:tenant_id])
            flash[:error] = "Not authorized to edit this profile!"
            redirect "tenants/#{@tenant.id}"
        end
      else
        flash[:error] = "Please log in!"
        redirect "/tenants/login"
      end
    end

    delete "/tenants/:id" do
      if tenant_logged_in? && params[:id] == session[:tenant_id].to_s
        Tenant.destroy(params[:id])
        flash[:message] = "Account successfully deleted"
        redirect to "/"
      else
        flash[:error] = "Please log in!"
        redirect "/tenants/login"
      end
    end

end