module Tenants
  def get_tenant_by_erpid(erpid)
    get_eapi("entitlements/customer.json/erpid/#{erpid}")
  end
  def get_tenant_by_email(email_address)
    get_eapi("entitlements/customer.json/email/#{email_address}")
  end
  def put_add_tenant(load)
    put_eapi("entitlements/customer.json/add", load)
  end
end