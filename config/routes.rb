Naturesoft::Areas::Engine.routes.draw do
  namespace :admin, module: "admin", path: "admin/content" do
    resources :countries do
      collection do
        put "enable"
        put "disable"
        delete 'delete'
      end
    end
  end
end