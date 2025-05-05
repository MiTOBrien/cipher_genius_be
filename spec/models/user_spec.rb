require 'rails_helper'

require "rails_helper"

RSpec.describe User, type: :model do
  describe "Relationships:" do
    it { should have_many(:user_ciphers) }
    it { should have_many(:ciphers).through(:user_ciphers)}
  end

  describe "Validations" do
    it { should validate_presence_of(:email) }
  end
end
