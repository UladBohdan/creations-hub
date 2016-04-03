ActiveAdmin.register Creation do

  permit_params :title, :user_id, ratings: [:user_id, :value]

end
