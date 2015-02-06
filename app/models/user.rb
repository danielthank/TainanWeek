class User < ActiveRecord::Base
  validates_presense_of :name, :student_id, :department, :mobile
end
