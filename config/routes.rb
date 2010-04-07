ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'user_accounts', :action => 'index'

  map.resource(:user_sessions, :as => 'sesion', :member => {:close => :get})

  map.resource(:user, :as => 'mis') do |user|
    user.resource(:profile, :controller => 'user_profiles', :as => 'datos')
    user.resources(:accounts, :controller => 'user_accounts', :as => 'cuentas')
  end
end
