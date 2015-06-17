ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes fullname, :sortable => true
  indexes email, :sortable => true
end