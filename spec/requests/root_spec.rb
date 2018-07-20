require_relative '../spec_helper'

describe 'Root path' do
  describe 'GET /' do
    it 'is successful' do
      get '/'
      expect(last_response.status).to eq 200
    end
  end
end
