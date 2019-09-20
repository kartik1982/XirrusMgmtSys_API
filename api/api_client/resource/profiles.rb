module Profiles
  # POST /profiles.json
  def post_profile(profile_load)
    post_api("profiles.json", profile_load)
  end    
end