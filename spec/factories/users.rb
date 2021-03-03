FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    password { '111aaa' }
    password_confirmation { '111aaa' }
    name_family { '山田' }
    name_first { '太郎' }
    name_family_kana { 'ヤマダ' }
    name_first_kana { 'タロウ' }
    birth_day { '2000-01-01' }
  end
end
