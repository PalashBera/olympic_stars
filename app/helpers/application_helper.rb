# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def full_title(page_title = "")
    base_title = t("page_title")

    if page_title.empty?
      base_title
    else
      "#{page_title} « #{base_title}"
    end
  end

  def flash_message_prefix(message_type)
    case message_type
    when "success" then t("alert_prefix.success")
    when "info"    then t("alert_prefix.info")
    when "warning" then t("alert_prefix.warning")
    when "danger"  then t("alert_prefix.danger")
    else ""
    end
  end

  def message_type(message_type)
    case message_type
    when "notice" then t("message_type.notice")
    when "alert"  then t("message_type.alert")
    else message_type
    end
  end

  def active_sidebar_item(str)
    "active" if str == @active_sidebar_item
  end

  def active_sidebar_sub_item(str)
    "active" if str == @active_sidebar_sub_item
  end
end
