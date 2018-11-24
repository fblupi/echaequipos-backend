require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'validations' do
    before(:each) do
      @group = create(:v1_group)
      @other_group = create(:v1_group)
      @affiliation = create(:v1_affiliation, group: @group)
      @other_affiliation = create(:v1_affiliation, group: @other_group)
      @match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1)
      @confirmed_match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1)
      create(:v1_player, affiliation: @affiliation, match: @confirmed_match)
      @confirmed_match.status = 'confirmed'
      @finished_match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1)
      create(:v1_player, affiliation: @affiliation, match: @finished_match)
      @finished_match.status = 'finished'
      @player = create(:v1_player, affiliation: @affiliation, match: @match)
    end

    it 'creates a player' do
      expect { Player.create!(affiliation: @affiliation, match: @match) }.to change(Player, :count).by(1)
    end

    it 'does not create a player with some mandatory parameter missing' do
      expect { Player.create!(affiliation: nil, match: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Player.create!(affiliation: @other_affiliation, match: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Player.create!(affiliation: nil, match: @match) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not create a player with a non proposal match' do
      expect { Player.create!(affiliation: @affiliation, match: @confirmed_match) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Player.create!(affiliation: @affiliation, match: @finished_match) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'status changes' do
    before(:each) do
      @group = create(:v1_group)
      @affiliation = create(:v1_affiliation, group: @group)
      @match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1)
      @player = create(:v1_player, affiliation: @affiliation, match: @match)
    end

    it 'updates the attending value of a proposal match' do
      expect { @player.confirm }.to change(@player, :attendance).to(true)
      expect { @player.quit }.to change(@player, :attendance).to(false)
    end

    it 'does not update the attending value to confirmed of a non proposal match' do
      @match.status = 'confirmed'
      expect { @player.confirm }.to raise_error(ActiveRecord::RecordInvalid)
      @match.status = 'finished'
      expect { @player.confirm }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not update the attending value to not confirmed of a non proposal match' do
      @player.confirm
      @match.status = 'confirmed'
      expect { @player.quit }.to raise_error(ActiveRecord::RecordInvalid)
      @match.status = 'finished'
      expect { @player.quit }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'scopes' do
    it 'attending' do
      @group = create(:v1_group)
      @affiliation = create(:v1_affiliation, group: @group)
      @other_affiliation = create(:v1_affiliation, group: @group)
      @match = create(:v1_match, group: @group, affiliation: @affiliation, status: 'proposal')
      expect { @player = Player.create!(affiliation: @affiliation, match: @match, attendance: true) }.to change(Player.attending, :count).by(1)
      expect { @other_player = Player.create!(affiliation: @other_affiliation, match: @match, attendance: false) }.to_not change(Player.attending, :count)
      expect { @other_player.confirm }.to change(Player.attending, :count).by(1)
    end
  end
end
