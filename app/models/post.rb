class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title
  before_save :create_slug!

  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  def create_slug!
    self.slug = slugify(title)
  end

  private

  def slugify(title)
    title.gsub!(/\s+/, "-")
    title.downcase!
    title.split("").select{ |e| e =~ /[a-z\-]/ }.join
  end

end
