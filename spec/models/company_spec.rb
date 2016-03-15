require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "validates" do
    it "should have a name" do
      company = Company.new(name: 'Just a company name', description: 'A cool yet superficial description')
      expect(company.valid?).to be(true)

      company = Company.new(name: '', description: 'A cool yet superficial description')
      expect(company.valid?).to be(false)
    end
    it "should have a unique name" do
      company = Company.create(name: 'Unique', description: 'Simply a unique company')
      expect(company.persisted?).to be(true)

      company_clone = Company.create(name: 'Unique', description: 'Another unique company')
      expect(company_clone.persisted?).to be(false)
    end
  end
end
