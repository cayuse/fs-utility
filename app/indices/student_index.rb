ThinkingSphinx::Index.define :student, :with => :active_record do
  # fields
  indexes name, :sortable => true
  indexes number, :sortable => true
end