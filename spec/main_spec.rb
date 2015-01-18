describe "Application 'freifunk_ios'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should > 0
  end
end
