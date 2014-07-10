Spree::State.class_eval do
  
  scope :unique_by_state_name, lambda { select(:name).order(:name).uniq}
  
end