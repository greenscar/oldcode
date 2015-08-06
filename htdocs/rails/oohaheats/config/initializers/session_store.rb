# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oohaheats_session',
  :secret      => '222937be1412ac8f234da7bfed10495f3deda164f79a9c4f2a60a07cc5155c485a50446f31232759e184376f039c7a053d4a851d9ac13d1b3d73a6031feefc10'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
