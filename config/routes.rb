Rails.application.routes.draw do
  #resources :pages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'pages',        to: 'pages#index' 
  get 'add',          to: 'pages#new_root'                      # [site]/add
  post 'add',         to: 'pages#create_root',  as: 'add_root'   
  get '*pages/add',   to: 'pages#new'                           # [site]/name1/name2/name3/add
  post '*pages/add',  to: 'pages#create',       as: 'add_page'  
  get '*pages/edit',  to: 'pages#edit'                          # [site]/name1/name2/name3/edit
  patch '*pages/edit', to: 'pages#update',       as: 'edit_page'
  get '*pages',       to: 'pages#show'                          # [site]/name1/name2/name3 - 
  # Defines the root path route ("/")
  # root "posts#index"
end

# Адресная схема мини-сайта:
# [site]/name1/name2/name3 - 
  # открывается страница с именем name3, 
  # которая является под-странице страницы name2, 
  # которая является под-страницей страницы name1. 
  # На странице виден её текст и заголовок, а также поддерево всех её подстраниц.
# [site]/name1/name2/name3/edit - 
  # страница открывается в режиме редактирования - можно редактировать заголовок и текст. 
  # После сохранения нужно делать редирект на адрес [site]/name1/name2/name3.
# [site]/name1/name2/name3/add - форма добавления подстраницы к текущей странице, 
  # можно задать имя, заголовок и текст. 
  # После добавления нужно делать редирект на адрес [site]/name1/name2/name3/[новое имя].
# [site]/add - форма добавления корневой страницы.