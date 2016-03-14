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
      @company = FactoryGirl.create(:energy_super, name: 'Giannithecompany')
      @owner = FactoryGirl.create(:energy_super_owner, email: 'giannitheowner@email.com', company: @company)

      @request.env["devise.mapping"] = Devise.mappings[:owner]
      @company = @owner.company
      sign_in @owner
    end
  end

  def login_front_end
    before(:each) do
      @company   = FactoryGirl.create(:energy_super, name: 'Energy Super 2')
      @front_end = FactoryGirl.create(:energy_super_front_end, company: @company, email: 'giannithefrontend@itbank.com')

      @request.env["devise.mapping"] = Devise.mappings[:energy_super_front_end]
      @company = @front_end.company
      sign_in @front_end
    end
  end
end