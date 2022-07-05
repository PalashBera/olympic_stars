# frozen_string_literal: true

module GroupsHelper
  def display_schedule_set(group)
    content_tag :div, class: "schedule-set" do
      group.schedule_set.collect do |schedule|
        content_tag(:span, schedule[:short_day], title: schedule[:day],
                                                 class: "schedule #{'checked' if schedule[:checked]}")
      end.join.html_safe
    end
  end

  def attendance_state(subscriber, date, attendances)
    attendance = attendances.detect { |a| a.attended?(subscriber, date) }
    attendance ? "Present" : "Absent"
  end
end
