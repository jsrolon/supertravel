class Plan < ActiveRecord::Base
  belongs_to :user
  serialize :events, Array
  validates_uniqueness_of :name

  def add_event(api_id)
    new_array = self.events.push(api_id.to_s)
    update_attribute :events, new_array
  end

  def remove_event(api_id)
    array = self.events
    array.delete(api_id)
    update_attribute :events, array
  end

end
