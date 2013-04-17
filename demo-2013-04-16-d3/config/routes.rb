Demo20130416D3::Application.routes.draw do
  root :to => 'master#clock'
  get 'names' => 'master#names'
  post 'names' => 'master#create_person'
  get 'remove_person' => 'master#remove_person'
end
