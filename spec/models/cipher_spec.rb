require "rails_helper"

RSpec.describe Cipher, type: :model do
  describe "Relationships:" do
    it { should have_many(:user_ciphers) }
    it { should have_many(:users).through(:user_ciphers)}
  end
end