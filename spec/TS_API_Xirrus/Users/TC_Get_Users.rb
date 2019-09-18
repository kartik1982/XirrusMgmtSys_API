describe "*****TESTCASE: GET Users API*********" do
  it "Verify get user from current tenant api" do
    response = @api.get_users_for_scoped_tenant
    expect(response.code).to eq(200)         
  end
end
