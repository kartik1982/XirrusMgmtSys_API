module Groups
  # GET /groups.json
  def get_groups
    get_api("groups.json")
  end   
  # POST /groups.json
  def post_group(load) 
    post_api("groups.json", load)
  end
  #PUT /groups.json/{groupId}/arrays
  def put_add_aps_to_group(group_id, load) 
    put_api("groups.json/#{group_id}/arrays", load)
  end
end