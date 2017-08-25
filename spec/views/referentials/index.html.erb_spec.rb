require "rails_helper"

RSpec.describe "referentials/index" do

  let!(:first_referential) { { "Id" => "42", "Slug" => "test" } }
  let!(:referentials) { assign(:referentials_tab, [ first_referential ] ) }

  it "should referential slug" do
    first_referential["Slug"] = "dummy"
    render
    expect(rendered).to have_selector("td.slug", :text => "dummy")
  end

  it "should referential tokens" do
    first_referential["Tokens"] = %w{token1 token2}
    render
    expect(rendered).to have_selector("td.tokens", :text => "token1,token2")
  end

end
