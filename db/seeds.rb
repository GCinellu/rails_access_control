# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

it_bank = Company.create name: 'IT Bank', description: 'Virtual Currency for your SPRINTS'

administrator = it_bank.users.new email: 'administrator@itbank.com', password: 'password'
administrator.roles << 'administrator'
administrator.save

energy_super = Company.create name: 'Energy Super', description: 'A young and fresh energy company'

owner = energy_super.users.create email: 'owner@itbank.com', password: 'password', company: energy_super
owner.roles << 'owner'
owner.save

departments_it = energy_super.departments.create name: 'IT', description: 'IT and R&D'
teams_it_front_ends = departments_it.teams.create name: 'Front Ends', description: 'Client and services maintainers', available_credit: 1000
teams_it_back_ends  = departments_it.teams.create name: 'Back Ends',  description: 'Back End API and CRM Devs', available_credit: 1000
teams_it_help_desk  = departments_it.teams.create name: 'Help Desk',  description: 'Help Desk and Data Validation', available_credit: 1000

it_manager = energy_super.users.create email: 'it_manager@itbank.com', password: 'password', company: energy_super
it_manager.roles << 'manager'
it_manager.department = departments_it
it_manager.save

front_end = energy_super.users.create email: 'front_end@itbank.com', password: 'password', company: energy_super
front_end.roles << 'developer'
front_end.teams << teams_it_front_ends
front_end.department = departments_it
front_end.save

back_end = energy_super.users.create email: 'back_end@itbank.com', password: 'password', company: energy_super
back_end.roles << 'developer'
back_end.teams << teams_it_back_ends
back_end.department = departments_it
back_end.save

help_desk = energy_super.users.create email: 'help_desk@itbank.com', password: 'password', company: energy_super
help_desk.roles << 'customer_care'
help_desk.teams << teams_it_help_desk
help_desk.department = departments_it
help_desk.save


departments_mktg = energy_super.departments.create name: 'Marketing', description: 'Online and Offline Acquisition/Retention'
teams_mktg_growth_hacking  = departments_mktg.teams.create name: 'Growth Hacking', description: 'Customer Analysis', available_credit: 1000
teams_mktg_graphic_design  = departments_mktg.teams.create name: 'Graphic Design',  description: 'Design of Website and supports', available_credit: 1000
teams_mktg_content         = departments_mktg.teams.create name: 'Content',  description: 'Media conception and creation', available_credit: 1000

mktg_manager = energy_super.users.new email: 'mktg_manager@itbank.com', password: 'password'
mktg_manager.roles << 'manager'
mktg_manager.department = departments_mktg
mktg_manager.save

growth_hacker = energy_super.users.new email: 'growth_hacker@itbank.com', password: 'password'
growth_hacker.roles << 'marketeer'
growth_hacker.teams << teams_mktg_growth_hacking
growth_hacker.department = departments_mktg
growth_hacker.save

graphic_designer = energy_super.users.new email: 'graphic_designer@itbank.com', password: 'password'
graphic_designer.roles << 'marketeer'
graphic_designer.teams << teams_mktg_graphic_design
graphic_designer.department = departments_mktg
graphic_designer.save

copywriter = energy_super.users.new email: 'copywriter@itbank.com', password: 'password'
copywriter.roles << 'marketeer'
copywriter.teams << teams_mktg_content
copywriter.department = departments_mktg
copywriter.save


departments_cc = energy_super.departments.create name: 'Customere Care', description: 'Front and Back Office'
teams_cc_front_office    = departments_cc.teams.create name: 'Front Office', description: 'Inbound Call Management', available_credit: 1000
teams_cc_back_office     = departments_cc.teams.create name: 'Back Office',  description: 'Solving internal issues with clients', available_credit: 1000
teams_cc_meter_readings  = departments_cc.teams.create name: 'Meter Readings',  description: 'A team highly focused on meter readings', available_credit: 1000

cc_manager = energy_super.users.new email: 'cc_manager@itbank.com', password: 'password'
cc_manager.roles << 'manager'
cc_manager.department = departments_cc
cc_manager.save

customer_care = energy_super.users.new email: 'customer_care@itbank.com', password: 'password'
customer_care.roles << 'customer_care'
customer_care.teams << teams_cc_front_office
customer_care.department = departments_cc
customer_care.save

back_office = energy_super.users.new email: 'back_office@itbank.com', password: 'password'
back_office.roles << 'customer_care'
back_office.teams << teams_cc_back_office
back_office.department = departments_cc
back_office.save

meter_reading = energy_super.users.new email: 'meter_reading@itbank.com', password: 'password'
meter_reading.roles << 'customer_care'
meter_reading.teams << teams_cc_meter_readings
meter_reading.department = departments_cc
meter_reading.save