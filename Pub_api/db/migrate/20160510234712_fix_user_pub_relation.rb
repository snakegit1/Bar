class FixUserPubRelation < ActiveRecord::Migration
  def change
  	remove_belongs_to :pubs, :users
  	add_belongs_to :pubs, :user
  end
end
