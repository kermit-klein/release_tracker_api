require 'coveralls'
Coveralls.wear_merged!('rails')
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require 'webmock/rspec'
WebMock.enable!
include WebMock::API
WebMock::API

require File.expand_path('../config/environment', __dir__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
api_key = Rails.application.credentials.movie_db[:api_key]
RSpec.configure do |config|
  config.include ResponseJSON
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name")
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.before do
    stub_request(:get, "https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=Will%20Smith&page=1&include_adult=false")
      .to_return(status: 200, body: file_fixture('will_smith_search_response.json'), headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&page=1&include_adult=false")
      .with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host'=>'api.themoviedb.org',
        'User-Agent'=>'rest-client/2.1.0 (darwin19.4.0 x86_64) ruby/2.5.1p57'
        })
      .to_return(status: 200, body: '{"errors": ["query must be provided"]}', headers: {})
    end
end
