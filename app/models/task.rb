class Task < ApplicationRecord
  belongs_to :user
  has_one_attached :eyecatch

  # def eyecatch_image
  #   if @task&.eyecatch&.attached?
  #     @task.eyecatch
  #   else
  #     'profile01.png'
  #   end
  # end

end
