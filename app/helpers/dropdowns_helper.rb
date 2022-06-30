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
    current_account.students.available_for_subscription.non_archived.order_by_first_name.map do |el|
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

  def year_dropdown_list
    (2010..Date.current.year).to_a.reverse
  end
end
