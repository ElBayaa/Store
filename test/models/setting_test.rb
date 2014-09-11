require 'test_helper'

class SettingTest < ActiveSupport::TestCase

  test "Normal Case" do
    s = Setting.new
    s.data_type = "String"
    s.key = "test key"
    s.value = "test value"
    s.save
    assert_equal s.errors.full_messages, []
  end

  test "key is required" do
    s = Setting.new
    s.data_type = "String"
    s.value = "value"
    s.save
    assert_includes s.errors.full_messages, "Key can't be blank"
  end

  test "supported types are String, Integer, Float and Boolean only" do
    s = Setting.new
    s.data_type = "Other"
    s.key = "unknow type"
    s.value = "value"
    s.save
    assert_includes s.errors.full_messages, "Data type is not included in the list"
  end

  test "Integer should be integer" do
    s = Setting.new
    s.data_type = "Integer"
    s.key = "int"
    s.value = "Ten"
    s.save
    assert_includes s.errors.full_messages, "Value is not a number"
    s.value = 10.0
    s.save
    assert_includes s.errors.full_messages, "Value must be an integer"
    s.value = 10
    s.save
    assert_equal s.errors.full_messages, []
  end

  test "Float should be float or integr" do
    s = Setting.new
    s.data_type = "Float"
    s.key = "float"
    s.value = "Ten"
    s.save
    assert_includes s.errors.full_messages, "Value is not a number"
    s.value = 10.0
    s.save
    assert_equal s.errors.full_messages, []
    s.value = 10
    s.save
    assert_equal s.errors.full_messages, []
  end

  test "Boolean is true or false" do
    s = Setting.new
    s.data_type = "Boolean"
    s.key = "True or False"
    s.value = "Ten"
    s.save
    assert_includes s.errors.full_messages, "Value is not included in the list"
    s.value = 10.0
    s.save
    assert_includes s.errors.full_messages, "Value is not included in the list"
    s.value = 10
    s.save
    assert_includes s.errors.full_messages, "Value is not included in the list"
    s.value = false
    s.save
    assert_equal s.errors.full_messages, []
    # 'true' and 'false' are also accepted
    s.value = 'false'
    s.save
    assert_equal s.errors.full_messages, []
  end
  
  test "Value should be store as a string but read in the correct data type" do
    s = Setting.new
    s.data_type = "Integer"
    s.key = "key"
    s.value = 10
    s.save
    s.reload
    assert_equal s.read_attribute(:value), '10'
    assert_equal s.value, 10
  end

  test "Data type normal operations should work" do
    s1 = Setting.new
    s1.data_type = "Integer"
    s1.key = "k1"
    s1.value = 10
    s1.save

    s2 = Setting.new
    s2.data_type = "Float"
    s2.key = "k2"
    s2.value = 10.0
    s2.save

    t = Setting.new
    t.data_type = "Boolean"
    t.key = "k3"
    t.value = true
    t.save

    f = Setting.new
    f.data_type = "Boolean"
    f.key = "k4"
    f.value = false
    f.save

    s1.reload
    s2.reload
    t.reload
    f.reload

    if t.value
      assert_equal(s1.value + s2.value, 20.0) 
    else
      assert false
    end

    unless f.value
      assert_equal(s1.value * s2.value, 100.0) unless f.value
    else
      assert false
    end
  end

end
