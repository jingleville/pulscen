require "test_helper"

class PageTest < ActiveSupport::TestCase
  test "page name must be unique within parent" do
    expect do
      create :page, name: "Home", parent: create(:page)
    end.to change(Page, :count).by(1)

    create :page, name: "About", parent: create(:page)
  end

  test 'page name format' do
    assert_raises(ActiveRecord::RecordInvalid) do
      create(:page, name: 'Homepage')
    end
  end

  test 'page path must be unique' do
    page = create(:page, path: 'about')
    expect { create(:page, parent: page, path: page.path) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  test 'child pages must have a parent' do
    child_page = Page.new
    expect(child_page).to receive(:parent_id).and_return(nil)
    expect { child_page.save! }.to raise_exception(ActiveModel::ForbiddenAttributesError)
  end

  test "pages with children must have a name" do
    parent_page = create :page
    child_page = Page.new parent: parent_page
    expect { child_page.valid? }.to raise_exception ActiveRecord::RecordInvalid
  end

  test "pages without parents must have a name" do
    page = Page.new(parent_id: nil)
    expect { page.valid? }.to raise_exception ActiveRecord::RecordInvalid, "Name can't be blank"
  end

  # test "the truth" do
  #   assert true
  # end
end
