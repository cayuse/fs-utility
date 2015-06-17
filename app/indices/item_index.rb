ThinkingSphinx::Index.define :item, :with => :active_record do
  indexes name, :sortable => true
end
