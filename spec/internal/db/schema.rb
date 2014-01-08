ActiveRecord::Schema.define do
  create_table(:pages, :force => true) do |t|
    t.string :name
    t.timestamps
  end

  create_table(:users, :force => true) do |t|
    t.string :name
    t.text   :content
    t.timestamps
  end
end