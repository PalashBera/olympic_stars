# frozen_string_literal: true

module DropdownsHelper
  def client_type_list(client_type_id)
    dropdown_list = current_account.client_types.non_archived.order_by_name.pluck(:name, :id)
    client_type_ids = dropdown_list.map { |e| e[1] }

    if client_type_id && !client_type_ids.include?(client_type_id)
      client_type = current_account.client_types.find(client_type_id)
      dropdown_list.prepend([client_type.name, client_type.id])
    end

    dropdown_list
  end

  def course_list(course_id)
    dropdown_list = current_account.courses.non_archived.order_by_name.pluck(:name, :id)
    course_ids = dropdown_list.map { |e| e[1] }

    if course_id && !course_ids.include?(course_id)
      course = current_account.courses.find(course_id)
      dropdown_list.prepend([course.name, course.id])
    end

    dropdown_list
  end

  def teacher_list(teacher_id)
    dropdown_list = current_account.teachers.non_archived.order_by_first_name.map do |teacher|
      [teacher.full_name, teacher.id]
    end
    teacher_ids = dropdown_list.map { |e| e[1] }

    if teacher_id && !teacher_ids.include?(teacher_id)
      teacher = current_account.teachers.find(teacher_id)
      dropdown_list.prepend([teacher.full_name, teacher.id])
    end

    dropdown_list
  end

  def payment_type_list(payment_type_id)
    dropdown_list = current_account.payment_types.non_archived.order_by_name.pluck(:name, :id)
    payment_type_ids = dropdown_list.map { |e| e[1] }

    if payment_type_id && !payment_type_ids.include?(payment_type_id)
      payment_type = current_account.payment_types.find(payment_type_id)
      dropdown_list.prepend([payment_type.name, payment_type.id])
    end

    dropdown_list
  end

  def payment_method_list(payment_method_id)
    dropdown_list = current_account.payment_methods.non_archived.order_by_name.pluck(:name, :id)
    payment_method_ids = dropdown_list.map { |e| e[1] }

    if payment_method_id && !payment_method_ids.include?(payment_method_id)
      payment_method = current_account.payment_methods.find(payment_method_id)
      dropdown_list.prepend([payment_method.name, payment_method.id])
    end

    dropdown_list
  end

  def student_payment_status_dropdown_list
    StudentPayment::STATUS_LIST.map { |el| [el.display, el] }
  end

  def teacher_payment_status_dropdown_list
    TeacherPayment::STATUS_LIST.map { |el| [el.display, el] }
  end

  def payment_type_category_dropdown_list
    PaymentType::CATEGORY_LIST.map { |el| [el.display, el] }
  end

  def available_student_dropdown_list
    current_account.students.not_subscribed.non_archived.order_by_first_name.map do |el|
      [el.full_name, el.id]
    end
  end

  def month_dropdown_list
    [
      ["January", 1], ["February", 2], ["March", 3], ["April", 4],
      ["May", 5], ["June", 6], ["July", 7], ["August", 8],
      ["September", 9], ["October", 10], ["November", 11], ["December", 12]
    ]
  end

  # rubocop:disable Metrics/MethodLength
  def time_dropdown_list
    [
      "00:00", "00:05", "00:10", "00:15", "00:20", "00:25", "00:30", "00:35", "00:40", "00:45", "00:50", "00:55",
      "01:00", "01:05", "01:10", "01:15", "01:20", "01:25", "01:30", "01:35", "01:40", "01:45", "01:50", "01:55",
      "02:00", "02:05", "02:10", "02:15", "02:20", "02:25", "02:30", "02:35", "02:40", "02:45", "02:50", "02:55",
      "03:00", "03:05", "03:10", "03:15", "03:20", "03:25", "03:30", "03:35", "03:40", "03:45", "03:50", "03:55",
      "04:00", "04:05", "04:10", "04:15", "04:20", "04:25", "04:30", "04:35", "04:40", "04:45", "04:50", "04:55",
      "05:00", "05:05", "05:10", "05:15", "05:20", "05:25", "05:30", "05:35", "05:40", "05:45", "05:50", "05:55",
      "06:00", "06:05", "06:10", "06:15", "06:20", "06:25", "06:30", "06:35", "06:40", "06:45", "06:50", "06:55",
      "07:00", "07:05", "07:10", "07:15", "07:20", "07:25", "07:30", "07:35", "07:40", "07:45", "07:50", "07:55",
      "08:00", "08:05", "08:10", "08:15", "08:20", "08:25", "08:30", "08:35", "08:40", "08:45", "08:50", "08:55",
      "09:00", "09:05", "09:10", "09:15", "09:20", "09:25", "09:30", "09:35", "09:40", "09:45", "09:50", "09:55",
      "10:00", "10:05", "10:10", "10:15", "10:20", "10:25", "10:30", "10:35", "10:40", "10:45", "10:50", "10:55",
      "11:00", "11:05", "11:10", "11:15", "11:20", "11:25", "11:30", "11:35", "11:40", "11:45", "11:50", "11:55",
      "12:00", "12:05", "12:10", "12:15", "12:20", "12:25", "12:30", "12:35", "12:40", "12:45", "12:50", "12:55",
      "13:00", "13:05", "13:10", "13:15", "13:20", "13:25", "13:30", "13:35", "13:40", "13:45", "13:50", "13:55",
      "14:00", "14:05", "14:10", "14:15", "14:20", "14:25", "14:30", "14:35", "14:40", "14:45", "14:50", "14:55",
      "15:00", "15:05", "15:10", "15:15", "15:20", "15:25", "15:30", "15:35", "15:40", "15:45", "15:50", "15:55",
      "16:00", "16:05", "16:10", "16:15", "16:20", "16:25", "16:30", "16:35", "16:40", "16:45", "16:50", "16:55",
      "17:00", "17:05", "17:10", "17:15", "17:20", "17:25", "17:30", "17:35", "17:40", "17:45", "17:50", "17:55",
      "18:00", "18:05", "18:10", "18:15", "18:20", "18:25", "18:30", "18:35", "18:40", "18:45", "18:50", "18:55",
      "19:00", "19:05", "19:10", "19:15", "19:20", "19:25", "19:30", "19:35", "19:40", "19:45", "19:50", "19:55",
      "20:00", "20:05", "20:10", "20:15", "20:20", "20:25", "20:30", "20:35", "20:40", "20:45", "20:50", "20:55",
      "21:00", "21:05", "21:10", "21:15", "21:20", "21:25", "21:30", "21:35", "21:40", "21:45", "21:50", "21:55",
      "22:00", "22:05", "22:10", "22:15", "22:20", "22:25", "22:30", "22:35", "22:40", "22:45", "22:50", "22:55",
      "23:00", "23:05", "23:10", "23:15", "23:20", "23:25", "23:30", "23:35", "23:40", "23:45", "23:50", "23:55"
    ]
  end
  # rubocop:enable Metrics/MethodLength

  def year_dropdown_list
    (2010..Date.current.year).to_a.reverse
  end
end
