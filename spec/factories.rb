FactoryGirl.define do
  factory :company do
    trait :is_it_bank do
      name        'IT Bank'
      description 'Virtual Currency for your SPRINTS'
    end

    trait :is_energy_super do
      name        'Energy Super'
      description 'A young and fresh energy company'
    end

    factory :it_bank,      traits: [:is_it_bank]
    factory :energy_super, traits: [:is_energy_super]
  end

  factory :department do
    association :company, factory: :energy_super, strategy: :build

    trait :is_it do
      name        'IT'
      description 'IT and R&D'
    end

    trait :is_mktg do
      name        'Marketing'
      description 'Online and Offline Acquisition/Retention'
    end

    trait :is_cc do
      name        'Customere Care'
      description 'Front and Back Office'
    end

    factory :departments_it,   traits: [:is_it]
    factory :departments_mktg, traits: [:is_mktg]
    factory :departments_cc,   traits: [:is_cc]
  end

  factory :user do
    association :company, factory: :energy_super, strategy: :build

    password 'password'

    trait :is_administrator do
      email 'administrator@itbank.com'
      roles %W{common administrator}
    end

    trait :is_owner do
      email 'owner@itbank.com'
      roles %W{common owner}
    end

    trait :is_front_end do
      email 'front_end@itbank.com'
      roles %W{common developer}
    end

    factory :administrator,          traits: [:is_administrator]
    factory :energy_super_owner,     traits: [:is_owner]
    factory :energy_super_front_end, traits: [:is_front_end]
  end

  # factory :owner_invalid_email, class: User do
  #   association :company, factory: :energy_super
  #   email    'invalid_email'
  #   password 'password'
  #   roles    %W{common owner}
  # end
  #
  # factory :teams_it_front_ends, class: Team do
  #   name        'Front Ends'
  #   description 'Client and services maintainers'
  # end
  #
  # factory :teams_it_back_ends, class: Team do
  #   name        'Front Ends'
  #   description 'Back End API and CRM Devs'
  # end
  #
  # factory :teams_it_help_desks, class: Team do
  #   name        'Front Ends'
  #   description 'Help Desk and Data Validation'
  # end
  #
  # factory :it_manager, class: User do
  #   association :company, factory: :energy_super
  #   email    'it_manager@itbank.com'
  #   password 'password'
  #   roles    %W{common manager}
  #   association :department, factory: :departments_it
  # end
  #
  # # factory :front_end, class: User do
  # #   association :company, factory: :energy_super
  # #   email 'front_end@itbank.com'
  # #   password 'password'
  # #
  # #   association :department, factory: :departments_it
  # #   association :team, factory: :teams_it_front_ends
  # # end
  #
  # factory :back_end, class: User do
  #   association :company, factory: :energy_super
  #   email 'back_end@itbank.com'
  #   password 'password'
  #   roles %W{common developer}
  #   departments_it
  #   teams_it_back_ends
  # end
  #
  # factory :help_desk, class: User do
  #   association :company, factory: :energy_super
  #   email 'help_desk@itbank.com'
  #   password 'password'
  #   roles %W{common customer_care}
  #   departments_it
  #   teams_it_help_desks
  # end
  #
  #
  # factory :teams_mktg_growth_hacking, class: Team do
  #   name 'Growth Hacking'
  #   description 'Customer Analysis'
  # end
  #
  # factory :teams_mktg_graphic_design, class: Team do
  #   name 'Graphic Design'
  #   description 'Design of Website and supports'
  # end
  #
  # factory :teams_mktg_content, class: Team do
  #   name 'Content'
  #   description 'Media conception and creation'
  # end
  #
  # factory :mktg_manager, class: User do
  #   association :company, factory: :energy_super
  #   email 'mktg_manager@itbank.com'
  #   password 'password'
  #   roles %W{common manager}
  #   departments_mktg
  # end
  #
  # factory :growth_hacker, class: User do
  #   association :company, factory: :energy_super
  #   email 'growth_hacker@itbank.com'
  #   password 'password'
  #   roles %W{common marketeer}
  #   departments_mktg
  #   teams_mktg_growth_hacking
  # end
  #
  # factory :graphic_designer, class: User do
  #   association :company, factory: :energy_super
  #   email 'graphic_designer@itbank.com'
  #   password 'password'
  #   roles %W{common marketeer}
  #   departments_mktg
  #   teams_mktg_graphic_design
  # end
  #
  # factory :copywriter, class: User do
  #   association :company, factory: :energy_super
  #   email 'copywriter@itbank.com'
  #   password 'password'
  #   roles %W{common marketeer}
  #   departments_mktg
  #   teams_mktg_content
  # end
  #
  # factory :teams_cc_front_office, class: Team do
  #   name 'Front Office'
  #   description 'Inbound Call Management'
  # end
  #
  # factory :teams_cc_back_office, class: Team do
  #   name 'Back Office'
  #   description 'Solving internal issues with clients'
  # end
  #
  # factory :teams_cc_meter_readings, class: Team do
  #   name 'Meter Readings'
  #   description 'A team highly focused on meter readings'
  # end
  #
  # factory :cc_manager, class: User do
  #   association :company, factory: :energy_super
  #   email 'mktg_manager@itbank.com'
  #   password 'password'
  #   roles %W{common manager}
  #   departments_cc
  # end
  #
  # factory :customer_care, class: User do
  #   association :company, factory: :energy_super
  #   email 'customer_care@itbank.com'
  #   password 'password'
  #   roles %W{common customer_care}
  #   departments_cc
  #   teams_cc_front_office
  # end
  #
  # factory :back_office, class: User do
  #   association :company, factory: :energy_super
  #   email 'back_office@itbank.com'
  #   password 'password'
  #   roles %W{common customer_care}
  #   departments_cc
  #   teams_cc_back_office
  # end
  #
  # factory :meter_reading, class: User do
  #   association :company, factory: :energy_super
  #   email 'meter_reading@itbank.com'
  #   password 'password'
  #   roles %W{common customer_care}
  #   departments_cc
  #   teams_cc_meter_readings
  # end
  #
  # factory :wish do
  #   team
  #   title 'Functionality Button'
  #   description 'It would allow us to be more proficient'
  #   impact_on_business 6
  #   time_required 9
  #   ease_of_development 9
  #   deadline { Date.today + 7 }
  # end
end