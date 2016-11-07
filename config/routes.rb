Naturesoft::Areas::Engine.routes.draw do
  namespace :backend, module: "backend", path: "backend/areas" do
    resources :areas do
      collection do
        delete "delete"
        get "select2"
      end
    end
    
    resources :countries do
      collection do
        put "enable"
        put "disable"
        delete "delete"
        get "select2"
      end
    end
  end
end