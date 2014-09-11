class Setting < ActiveRecord::Base

  validates :key, presence: true, uniqueness: true
  validates :data_type, inclusion: %w(String Integer Float Boolean)

  validates :value, numericality: {only_integer: true}, if: "data_type == 'Integer'"
  validates :value, numericality: true, if: "data_type == 'Float'"
  validates :value, inclusion: [true, false], if: "data_type == 'Boolean'"

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
end
