module ControllerMacros
  def login_administrator
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:administrator]
      @administrator = FactoryGirl.create(:administrator, email: 'superadmin@itbank.com')
      sign_in :user, @administrator
    end
  end

  def login_owner
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:owner]
      @owner = FactoryGirl.create(:energy_super_owner)
      sign_in :owner, @owner
    end
  end
end