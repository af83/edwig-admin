require "rails_helper"

RSpec.describe "referentials/index" do

  let!(:first_referential) { { "Id" => "42", "Slug" => "test" } }
  let!(:referentials) { assign(:referentials_tab, [ first_referential ] ) }

  it "should display referential slug" do
    first_referential["Slug"] = "dummy"
    render
    expect(rendered).to have_selector("td.slug", :text => "dummy")
  end

  it "should display referential tokens" do
    first_referential["Tokens"] = %w{token1 token2}
    render
    expect(rendered).to have_selector("td.tokens", :text => "token1,token2")
  end

  context "when referential has token" do
    before { first_referential["Tokens"] = %w{dummy} }
    it "should include a link to show the referential" do
      render
      expect(rendered).to have_selector("a.show")
    end
    it "should include a link to edit the referential" do
      render
      expect(rendered).to have_selector("a.edit")
    end
    it "should include a link to delete the referential" do
      render
      expect(rendered).to have_selector("a.delete")
    end
  end

  context "when referential has no token", pending: "#4305" do
    before { first_referential["Tokens"] = nil }
    it "should not include a link to show the referential" do
      render
      expect(rendered).to_not have_selector("a.show")
    end
    it "should not include a link to edit the referential" do
      render
      expect(rendered).to_not have_selector("a.edit")
    end
    it "should not include a link to delete the referential" do
      render
      expect(rendered).to_not have_selector("a.delete")
    end
  end

end
