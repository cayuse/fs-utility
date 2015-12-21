Rails.application.routes.draw do
  resources :notes

  resources :dietdocuments

  resources :site_settings

  resources :categories

  resources :conditions

  resources :diagnoses

  resources :diets
  
  resources :accounts

  resources :schoolyears

  resources :meals

  devise_for :users
  root :to => "visitors#index"
  scope "/admin" do
    resources :users
  end

  resources :renames

post 'monthlyinvreqs/dispatch_pdf', to: 'monthlyinvreqs#dispatch_pdf'
post 'monthlyinvreqs/new', to: 'monthlyinvreqs#new'
get  'monthlyinvreqs/start', to: 'monthlyinvreqs#start'

get 'monthlyinvs/create', to: 'monthlyinvs#create'
get 'weeklydfcorders/create', to: 'weeklydfcorders#create'

get 'weeklyorderreqs/monthlyindex', to: 'weeklyorderreqs#monthlyindex'
post 'weeklyorderreqs/monthsdispatch', to: 'weeklyorderreqs#monthsdispatch'
post 'weeklyorderreqs/reports', to: 'weeklyorderreqs#reports'


post 'weeklyorderreqs/new', to: 'weeklyorderreqs#new'
get 'weeklyorderreqs/start', to: 'weeklyorderreqs#start'

post 'storelocs/update_itemlocs', to: 'storelocs#update_itemlocs'

resources :worksheets, :companies, :bidnames, :foodvendors, :nutritionals
resources :track_calendars, :monthlyinvitems, :monthlyinvs
resources :usages, :weeks, :itemtypes, :weeklydfcorders
resources :tracks, :sitetypes, :sites, :weeklyorderreqs
resources :setting, :students, :monthlyinvreqs


get  'storelocs/setup', to: 'storelocs#setup'
post  'storelocs/setup', to: 'storelocs#setup'


get  'settings/edit', to: 'settings#edit'
post 'settings/create', to: 'settings#update'
resources :settings

post 'items/new',     to: "items#new"
get 'items/reorder', to: "items#reorder"
post 'items/expire', to: "items#expire"
resources :items

post 'storelocs/update_order',to: "storelocs#update_order"
get 'storelocs/setup', to: "storelocs#setup"
resources :storelocs

end
