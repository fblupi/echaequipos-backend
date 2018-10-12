module ControllerMacros
  def login_v1_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:v1_user]
      user = FactoryBot.create(:v1_user)
      sign_in user, scope: :v1_user
    end
  end
end