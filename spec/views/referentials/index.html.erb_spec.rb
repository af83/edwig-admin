require "rails_helper"

RSpec.describe "referentials/index" do

  let!(:first_referential) { { "Id" => "42", "Slug" => "test" } }
  let!(:referentials) { assign(:referentials_tab, [ first_referential ] ) }

  it "should display referential slug" do
    first_referential["Slug"] = "dummy"
    render
    expect(rendered).to have_selector("td.slug", :text => "dummy")
  end

  it "should display referential token count" do
    first_referential["Tokens"] = %w{token1 token2}
    render
    expect(rendered).to have_selector("td.tokens", :text => 2)
  end

  context "when referential has token" do
    before { first_referential["Tokens"] = %w{dummy} }
    it "should include a link to show the referential" do
      render
      expect(rendered).to have_selector("li.show-action")
    end
    it "should include a link to edit the referential" do
      render
      expect(rendered).to have_selector("li.edit-action")
    end
    it "should include a link to delete the referential" do
      render
      expect(rendered).to have_selector("li.delete-action")
    end
  end

  context "when referential has no token", pending: "#4305" do
    before { first_referential["Tokens"] = nil }
    it "should not include a link to show the referential" do
      render
      expect(rendered).to_not have_selector("li.show-action")
    end
    it "should not include a link to edit the referential" do
      render
      expect(rendered).to_not have_selector("li.edit-action")
    end
    it "should not include a link to delete the referential" do
      render
      expect(rendered).to_not have_selector("li.delete-action")
    end
  end

end
