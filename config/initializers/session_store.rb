# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_calcountancy_session',
  :secret      => '8fe80c6e14882e4fe7c4e224a0615a5c512155710ea5d1ce0e7c678a0e298ef2c3fb7072463dd9faa958f889dcb5422dcd8f9f5fe73b2c77770cfa77a7212743'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
