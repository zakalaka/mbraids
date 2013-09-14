authorization do
  role :guest do
    #has_permission_on :accounts, :to => [:index]
  end

  # these role names are coming from the db and the method is defined in the user's model
  role :admin do
    includes :guest
    has_permission_on :accounts, :to => [:index, :new, :create, :edit, :update, :destroy]
    has_permission_on :hairstyles, :to => [:index, :new, :create, :edit, :update, :destroy]
    has_permission_on :appointments, :to => [:index, :new, :create]
  end
end