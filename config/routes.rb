ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'user_accounts', :action => 'index'

  map.resource(:user_sessions, :as => 'sesion', :member => {:close => :get})

  map.resource(:user, :as => 'mis') do |user|
    user.resources(:tags, :controller => 'user_tags', :as => 'tags')
    user.resource(:profile, :controller => 'user_profiles', :as => 'datos')
    user.resources(:accounts, :controller => 'user_accounts', :as => 'cuentas') do |account|
      account.resource(:bulk_action, :controler => 'bulk_actions', :as => 'bulk')
      account.resource(:import, :controller => 'user_account_imports', :as => 'importar', :member => {:preview => :post})
      account.resources(:tags, :controller => 'user_account_tags', :as => 'tags')
      account.resources(:month_summaries, :controller => 'user_account_month_summaries', :as => 'ver')
      account.resources(:year_summaries, :controller => 'year_summaries', :as => 'anyo')
      account.resources(:quarter_summaries, :controller => 'quarter_summaries', :as => 'q')
    end
  end

  map.resources(:movements, :as => 'movimientos', :member => {:comentar => :post})
  map.resources(:taggings, :as => 'taggings')
end
