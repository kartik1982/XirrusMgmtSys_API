module Easypass
  # POST /easypass.json
  def post_add_easypass_portal(porta_load)
    post_api("easypass.json", porta_load)
  end    
end