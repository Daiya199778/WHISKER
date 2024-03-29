source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.2'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'webdrivers'
  gem 'faker'
  gem "sqlite3"
end

group :production do
  # Use PstgreSQL as the database for Active Record
  gem 'pg'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener_web', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'font-awesome-sass', '~> 5.11.2'
gem 'jquery-rails'
gem 'sorcery'
gem 'pry-byebug'
gem 'rails-i18n'
gem 'enum_help'
#画像を投稿するためのgem
gem 'carrierwave'
#画像のサイズ調整のためのgem
gem 'mini_magick'
#ページネーションのためのgem
gem 'kaminari'
#検索機能のgem
gem 'ransack', '~> 3.2', '>= 3.2.1'
#AWSで画像保存でするgem
gem 'fog-aws'
gem "aws-sdk-s3", require: false 
#環境変数を他に見られないように管理するgem
gem 'dotenv-rails'
#googleの位置情報機能のgem
gem 'gon'
gem 'google_places'
#認証関連のgem
gem 'config'
gem 'omniauth-twitter'