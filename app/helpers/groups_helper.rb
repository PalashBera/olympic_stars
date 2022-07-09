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
    attendance ? t("messages.attendance.present") : t("messages.attendance.absent")
  end

  def display_subscribers_count(group)
    if group.overloaded?
      content_tag(:span, group.subscribers_count, title: t("messages.group.overloaded"), class: "text-danger")
    else
      group.subscribers_count
    end
  end
end
