module Users
  class PreferencesController < ActionController::API
    before_action :authenticate_user!

    def create
      current_user.preference.update(preferences_params)
    end

    private

    def preferences_params
      params.require(:preferences).permit(:period, :on, :at)
    end
  end
end
