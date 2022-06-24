# frozen_string_literal: true

module LinksHelper
  def student_group_link(student)
    link_to student.group_name, coaching_group_path(student.group), title: "Show group" if student.group.present?
  end
end
