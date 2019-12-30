Fabricator(:test)  do
  starting_date Time.current + 3.days
  ending_date Time.current + 33.days
  one_week_before_starting_date Time.current - 7.days
  one_week_before_ending_date Time.current - 1.days
  two_week_before_starting_date Time.current - 14.days
  two_week_before_ending_date Time.current - 1.days
  four_week_before_starting_date Time.current - 30.days
  four_week_before_ending_date Time.current - 1.days
  one_week_after_starting_date Time.current + 3.days
  one_week_after_ending_date Time.current + 10.days
  two_week_after_starting_date Time.current + 3.days
  two_week_after_ending_date Time.current + 17.days
  four_week_after_starting_date Time.current + 3.days
  four_week_after_ending_date Time.current + 33.days
  title 'this is the new title'
  description 'this is the new description'
end

