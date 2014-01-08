source 'https://rubygems.org'

# Specify your gem's dependencies in activerecord_cashier.gemspec
gemspec


rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "master"
  {github: "rails/rails"}
when "default"
  "~> 4.0.0"
when "pre"
  '~> 4.1.0.beta1'
else
  "~> #{rails_version}"
end

gem "rails", rails