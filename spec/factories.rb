FactoryGirl.define do

  factory :user do
    name      "Usuario"
    last_name "Ejemplo"
    email     "usuario@ejemplo.com"
    password  "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :comment do
    content "Lorem ipsun"
    user
  end
end

