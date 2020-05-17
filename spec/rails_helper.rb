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

api_key = Rails.application.credentials.movie_db[:api_key]

RSpec.configure do |config|
  config.include ResponseJSON
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.filter_gems_from_backtrace('webmock')
  config.filter_gems_from_backtrace('rest-client')
  config.filter_gems_from_backtrace('rack*')
  config.filter_gems_from_backtrace('bootsnap')
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.before do
    stub_request(:get, "https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=Will%20Smith&page=1&include_adult=false")
      .to_return(status: 200, body: file_fixture('will_smith_search_response.json'), headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=&page=1&include_adult=false")
      .to_return(status: :unprocessable_entity, body: '{"result": {"errors": ["query must be provided"]} }', headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=uuaaoo&page=1&include_adult=false")
      .to_return(status: 200, body: file_fixture('no_content.json'), headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/person/31/movie_credits?api_key=#{Rails.application.credentials.movie_db[:api_key]}")
      .to_return({ status: 200, body: file_fixture('tom_hanks_credits.json'), headers: {} })
    stub_request(:get, "https://api.themoviedb.org/3/person/33/movie_credits?api_key=#{Rails.application.credentials.movie_db[:api_key]}")
      .to_return({ status: 200, body: file_fixture('tom_hanks_stopped_working.json'), headers: {} })
    stub_request(:get, "https://api.themoviedb.org/3/person/2328?api_key=#{Rails.application.credentials.movie_db[:api_key]}")
      .to_return({ status: 200, body: file_fixture('about_manuel_corrales.json'), headers: {} })
  end
end
