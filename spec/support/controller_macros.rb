module ControllerMacros
  def login_administrator
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      administrator = FactoryGirl.create(:administrator)
      sign_in :administrator, administrator
    end
  end

  def login_owner
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @owner = FactoryGirl.create(:owner)
      sign_in :owner, @owner
    end
  end
end