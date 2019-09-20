module Easypass
  #GET /easypass.json
  def get_all_easypass_portals
    get_papi("easypass.json")  
  end
  #GET /easypass.json/{portalName}
  def get_easypass_portal_by_name(portal_name)
    get_papi("easypass.json/#{portal_name}")
  end 
  #GET /easypass.json/{portalName}/ssids
  def get_ssids_for_easypass_portal(portal_name)
    get_papi("easypass.json/#{portal_name}/ssids")
  end
  #POST /easypass.json/{portalName}/guests
  def post_add_guest_to_easypass_portal(portal_name, guest_load)
    post_papi("easypass.json/#{portal_name}/guests", guest_load)
  end  
  #GET /easypass.json/{portalName}/guests/{email}
  def get_guest_from_easypass_portal_with_email(portal_name, guest_email)
    get_papi("easypass.json/#{portal_name}/guests/#{guest_email}")
  end
  #GET /easypass.json/{portalName}/guests
  def get_all_guest_from_easypass_portal(portal_name)
    get_papi("easypass.json/#{portal_name}/guests")
  end
  #PUT /easypass.json/{portalName}/guests/{email}
  def put_update_guest_to_easypass_portal(portal_name, guest_email, guest_load)
    put_papi("easypass.json/#{portal_name}/guests/#{guest_email}", guest_load)
  end
  #DELETE /easypass.json/{portalName}/guests/{email}
  def delete_guest_from_easypass_portal_using_email(portal_name, guest_email)
    delete_papi("easypass.json/#{portal_name}/guests/#{guest_email}")
  end 
  #DELETE /easypass.json/{portalName}/guests
  def delete_all_guest_from_easypass(portal_name)
    delete_papi("easypass.json/#{portal_name}/guests")
  end
  #POST /easypass.json/{portalName}/psks
  def post_add_psk_to_easypass_portal(portal_name, psk_load)
    post_papi("easypass.json/#{portal_name}/psks", psk_load)
  end
  #GET /easypass.json/{portalName}/psks/{userId}
  def get_psk_for_easypass_portal_with_userid(portal_name, user_id)
    get_papi("easypass.json/#{portal_name}/psks/#{user_id}") 
  end
  #GET /easypass.json/{portalName}/psks
  def get_psk_for_easypass_portal(portal_name)
    get_papi("easypass.json/#{portal_name}/psks") 
  end
  #DELETE /easypass.json/{portalName}/psks/{userId}
  def delete_psk_for_easypass_portal(portal_name, user_id)
    delete_papi("easypass.json/#{portal_name}/psks/#{user_id}") 
  end
  #PUT /easypass.json/{portalName}/psks/{userId}
  def put_update_psk_to_easypass_portal(portal_name, user_id, psk_load)
    put_papi("easypass.json/#{portal_name}/psks/#{user_id}", psk_load)
  end
end