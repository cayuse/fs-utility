ThinkingSphinx::Index.define :item, :with => :active_record do
  indexes :name, :sortable => true
  indexes :mfgname
  indexes :mfgcode
  indexes :ordercode
end
