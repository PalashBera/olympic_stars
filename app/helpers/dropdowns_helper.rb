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

  def fee_list(fee_id)
    dropdown_list = current_account.fees.non_archived.order_by_name.pluck(:name, :id)
    fee_ids = dropdown_list.map { |e| e[1] }

    if fee_id && !fee_ids.include?(fee_id)
      fee = current_account.fees.find(fee_id)
      dropdown_list.prepend([fee.name, fee.id])
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
end
