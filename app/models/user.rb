class User < ActiveRecord::Base
  validates_presence_of :name, :student_id, :department, :mobile
end
