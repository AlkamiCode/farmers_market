require 'rails_helper'

describe StoresController do
  describe 'controller can get #index' do
    before do
      get :index
    end
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :html }
    it { is_expected.to render_with_layout :application }
    it { is_expected.to render_template :index }
  end
end
