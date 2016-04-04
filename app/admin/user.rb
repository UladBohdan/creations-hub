ActiveAdmin.register User do

  permit_params :image, :name, :email

end
