module Tenants
  def get_tenant_by_erpid(erpid)
    resource_path= "entitlements/customer.json/erpid/#{erpid}"
    load={}
    args = ent_common_params.update({resource_path: resource_path, load: load})   
    get(args)
  end
  def get_tenant_by_email(email)
    resource_path= "entitlements/customer.json/email/#{email}"
    load={}
    args = ent_common_params.update({resource_path: resource_path, load: load})   
    get(args)
  end
  def add_tenant(tenant_load)
    resource_path= "entitlements/customer.json/add"
    load=tenant_load
    args = ent_common_params.update({resource_path: resource_path, load: load})   
    put(args)
  end
end