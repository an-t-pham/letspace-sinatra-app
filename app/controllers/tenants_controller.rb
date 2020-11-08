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
           redirect "/tenants/#{tenant.id}"
        else
          redirect "/tenants/login"
        end
      end

    get "/tenants/signup" do
        erb :"/tenants/signup"
    end
    
    post "/tenants" do
      @tenant = Tenant.create(params)
    
       session[:tenant_id] = @tenant.id
    
       redirect "/tenants/#{@tenant.id}"
    end

    get "/tenants/:id" do
        @tenant = Tenant.find_by(id: params[:id])
        erb :"/tenants/show"
      end
    
    get "/tenants/:id/edit" do
        @tenant = Tenant.find(params[:id])
        erb :"/tenants/edit"
    end
    
    patch "/tenants/:id" do
        @tenant = Tenant.find(params[:id])
        @tenant.update(params[:tenant])
        redirect "/tenants/#{@tenant.id}"
    end

    delete "/tenants/:id" do
        Tenant.destroy(params[:id])
        redirect to "/"
      end

end