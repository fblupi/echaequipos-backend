require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'validations' do
    before(:each) do
      @group = create(:v1_group)
      @other_group = create(:v1_group)
      @affiliation = create(:v1_affiliation, group: @group)
      @other_affiliation = create(:v1_affiliation, group: @other_group)
    end

    it 'creates a match' do
      expect { create(:v1_match, group: @group, affiliation: @affiliation) }.to change(Match, :count).by(1)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, latitude: nil) }.to change(Match, :count).by(1)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, longitude: nil) }.to change(Match, :count).by(1)
    end

    it 'does not create a match with some mandatory parameter missing' do
      expect { create(:v1_match, group: nil, affiliation: @affiliation) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, date: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, duration: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, status: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, min_players: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, max_players: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, location: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not create a match with bad duration' do
      expect { create(:v1_match, group: @group, affiliation: @affiliation, duration: 0) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, duration: -1) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, duration: 0.4) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, duration: 1) }.to change(Match, :count).by(1)
    end

    it 'does not create a match with bad date' do
      expect { create(:v1_match, group: @group, affiliation: @affiliation, date: Time.zone.now + 5.years + 1.minute) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, date: Time.zone.now - 1.minute) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, date: Time.zone.now) }.to change(Match, :count).by(1)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, date: Time.zone.now + 5.years - 1.minute) }.to change(Match, :count).by(1)
    end

    it 'does not create a match with an affiliation from another group' do
      expect { create(:v1_match, group: @group, affiliation: @other_affiliation) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @other_group, affiliation: @affiliation) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not create a match with bad min or max players' do
      expect { create(:v1_match, group: @group, affiliation: @affiliation, min_players: 5, max_players: 4) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, min_players: -1, max_players: 0) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, min_players: -0.5, max_players: 0) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, min_players: 0, max_players: 0) }.to change(Match, :count).by(1)
      expect { create(:v1_match, group: @group, affiliation: @affiliation, min_players: 0, max_players: 1) }.to change(Match, :count).by(1)
    end
  end

  describe 'status changes' do
    before(:each) do
      @group = create(:v1_group)
      @affiliation = create(:v1_affiliation, group: @group)
      @other_affiliation = create(:v1_affiliation, group: @group)
      @another_affiliation = create(:v1_affiliation, group: @group)
      @match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1, max_players: 2)
      @player = create(:v1_player, affiliation: @affiliation, match: @match)
      @other_player = create(:v1_player, affiliation: @another_affiliation, match: @match)
      @another_player = create(:v1_player, affiliation: @another_affiliation, match: @match)
    end

    it 'does not create a match with bad min players' do
      expect { @match.confirm }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not create a match with bad max players' do
      @player.confirm
      @other_player.confirm
      @another_player.confirm
      expect { @match.confirm }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not create a match with bad max players' do
      @player.confirm
      @other_player.confirm
      @another_player.confirm
      @another_player.quit
      expect { @match.confirm }.to change(@match, :status).to('confirmed')
    end
  end

  describe 'attributes of finished match' do
    before(:each) do
      @group = create(:v1_group)
      @affiliation = create(:v1_affiliation, group: @group)
      @match = create(:v1_match, group: @group, affiliation: @affiliation)
    end

    it 'allows to update attributes of proposed match' do
      expect { @match.update!(name: 'test') }.to_not raise_error
      expect { @match.update!(date: Time.zone.now + 1.week) }.to_not raise_error
      expect { @match.update!(duration: 15) }.to_not raise_error
      expect { @match.update!(location: 'test') }.to_not raise_error
      expect { @match.update!(min_players: 0) }.to_not raise_error
      expect { @match.update!(max_players: 0) }.to_not raise_error
      expect { @match.update!(status: 'confirmed') }.to_not raise_error
      expect { @match.update!(latitude: 0.0) }.to_not raise_error
      expect { @match.update!(longitude: 0.0) }.to_not raise_error
    end

    it 'allows to update attributes of proposed match' do
      @match.update(min_players: 0)
      @match.confirm
      expect { @match.update!(name: 'test') }.to_not raise_error
      expect { @match.update!(date: Time.zone.now + 1.week) }.to_not raise_error
      expect { @match.update!(duration: 15) }.to_not raise_error
      expect { @match.update!(location: 'test') }.to_not raise_error
      expect { @match.update!(min_players: 0) }.to_not raise_error
      expect { @match.update!(max_players: 0) }.to_not raise_error
      expect { @match.update!(status: 'confirmed') }.to_not raise_error
      expect { @match.update!(latitude: 0.0) }.to_not raise_error
      expect { @match.update!(longitude: 0.0) }.to_not raise_error
    end

    it 'does not allow to update attributes of finished match' do
      @match.finish
      expect { @match.update!(name: 'test') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(date: Time.zone.now + 1.week) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(duration: 15) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(location: 'test') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(min_players: 0) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(max_players: 0) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(status: 'confirmed') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(latitude: 0.0) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @match.update!(longitude: 0.0) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
