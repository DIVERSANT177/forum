class ConverAttachmentToPolymorphic < ActiveRecord::Migration[7.2]
  def change
    remove_index :attachments, :question_id
    rename_column :attachments, :question_id, :attachmentable_id

    add_column :attachments, :attachmentable_type, :string
    add_index :attachments, [ :attachmentable_id, :attachmentable_type ], name: 'index_attachments_on_attachable'
  end
end
