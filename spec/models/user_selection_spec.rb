require 'rails_helper'

RSpec.describe UserSelection, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :person_id }
  end

  describe 'Relations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:user_selection)).to be_valid
    end
  end
end