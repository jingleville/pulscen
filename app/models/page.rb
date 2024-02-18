class Page < ApplicationRecord
  acts_as_tree
  has_many :children, :class_name => 'Page', :foreign_key => 'parent_id'
  validates :name, format: { with: /\A[a-zA-ZА-Яа-яЁё0-9_]+\z/, message: "You can't give a page that name" }
  validates :name, uniqueness: { scope: :parent_id,
    message: "This page already has subpage with this name" }
  validates :path, uniqueness: true
end
