# frozen_string_literal: true

module LinksHelper
  def student_group_link(student)
    link_to student.group_name, coaching_group_path(student.group), title: "Show details" if student.group.present?
  end

  def attendance_link(subscriber, date, attendances)
    attendance = attendances.detect { |a| a.attended?(subscriber, date) }

    if attendance
      absent_link(subscriber, attendance)
    else
      present_link(subscriber, date)
    end
  end

  def absent_link(subscriber, attendance)
    link_to raw("<i class='text-success bi bi-check-circle-fill'></i>"),
            coaching_group_attendance_path(subscriber.group_id, attendance.id),
            title: "Mark absent",
            data: {
              "turbo-method": :delete,
              turbo_confirm: "Are you sure you want to mark absent for #{subscriber.student_full_name}?"
            }
  end

  def present_link(subscriber, attend_date)
    link_to raw("<i class='bi bi-x-circle-fill'></i>"),
            coaching_group_attendances_path(group_id: subscriber.group_id, attendance: {
                                              date: attend_date, subscriber_id: subscriber.id
                                            }),
            title: "Mark present",
            class: attend_date < Date.current ? "text-danger" : "text-grey",
            data: {
              "turbo-method": :post,
              turbo_confirm: "Are you sure you want to mark present for #{subscriber.student_full_name}?"
            }
  end

  def income_expense_resource_link(resouce)
    case resouce
    when StudentPayment
      link_to resouce.serial,
              coaching_student_student_payment_path(resouce.student_id, resouce.id),
              title: "Show details", data: { turbo_frame: "remote_modal_form" }
    when TeacherPayment
      link_to resouce.serial,
              personal_teacher_teacher_payment_path(resouce.teacher_id, resouce.id),
              title: "Show details", data: { turbo_frame: "remote_modal_form" }
    end
  end
end
