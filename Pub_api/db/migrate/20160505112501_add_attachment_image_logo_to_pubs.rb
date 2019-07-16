class AddAttachmentImageLogoToPubs < ActiveRecord::Migration
  def self.up
    change_table :pubs do |t|
      t.attachment :image_logo
    end
  end

  def self.down
    remove_attachment :pubs, :image_logo
  end
end
