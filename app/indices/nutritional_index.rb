ThinkingSphinx::Index.define :nutritional, :with => :active_record do
  # fields
  indexes name, :sortable => true
  indexes codenum, :sortable => true
  indexes search

  has created_at, updated_at
end
  