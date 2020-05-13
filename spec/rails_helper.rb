# frozen_string_literal: true

require 'coveralls'
Coveralls.wear_merged!('rails')
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

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

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name")
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include ResponseJSON
  config.before do
    stub_request(:get, "https://api.themoviedb.org/3/person/31/movie_credits?api_key=#{Rails.application.credentials.movie_db[:api_key]}")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'api.themoviedb.org',
          'User-Agent' => 'rest-client/2.1.0 (linux-gnu x86_64) ruby/2.5.1p57'
        }
      ).to_return({ status: 200, body: file_fixture('tom_hanks_credits.json'), headers: {} })
  end
end
