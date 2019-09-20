describe "*****TESTCASE: GET Users API*********" do
  it "Verify get user from current tenant api" do
    response = @api.get_users
    expect(response.code).to eq(200)         
  end
end
