class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.string     :sender_name
      t.string     :sender_email
      t.string     :title
      t.text       :message

      t.timestamps
    end

    add_foreign_key :messages, :users, on_delete: :cascade
  end
end
