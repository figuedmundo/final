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

  factory :place do
    name  "Bar"
    address "Bar y Baz"
    desc  "Ipsun loren"
    lat   1.01
    lng   1.01
    # coord "POINT(12.210 21.01)"
    user
  end

  factory :comment do
    content "Lorem ipsun"
    user
    # place
  end

end

