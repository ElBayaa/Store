class Setting < ActiveRecord::Base

  validates :key, presence: true, uniqueness: true
  validates :data_type, inclusion: %w(String Integer Float Boolean)

  validates :value, numericality: {only_integer: true}, if: "data_type == 'Integer'"
  validates :value, numericality: true, if: "data_type == 'Float'"
  validates :value, inclusion: [true, false], if: "data_type == 'Boolean'"

  after_commit :flush_cache


  def value
    case data_type
    when 'Integer'
      read_attribute(:value).to_i
    when 'Float'
      read_attribute(:value).to_f
    when 'Boolean'
      read_attribute(:value) == 't'
    else
      read_attribute(:value)
    end
  end

  def self.all_cached
    Rails.cache.fetch(name) {all}
  end

  def self.find_cached(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(self.class.name)
  end

end
