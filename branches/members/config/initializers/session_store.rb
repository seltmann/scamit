# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scamit_session',
  :secret      => 'e4d343926de8bdb42574614b848329669c5bf7f565f50185c7dc9e42fd91d188d3280c92a414066f65e0080ed51a38c95de98e5c2469cffaeb4b8941661707eb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
