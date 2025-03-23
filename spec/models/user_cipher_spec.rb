require "rails_helper"

RSpec.describe UserCipher, type: :model do
  describe "Relationships:" do
    it { should belong_to(:user) }
    it { should belong_to(:cipher) }
  end

  describe "Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:cipher_id) }
  end
end