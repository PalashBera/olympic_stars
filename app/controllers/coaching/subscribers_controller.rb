# frozen_string_literal: true

module Coaching
  class SubscribersController < Coaching::HomeController
    before_action { active_sidebar_sub_item_option("groups") }

    def index
      @search = group.subscribers.ransack(params[:q])
      @search.sorts = "student_first_name asc" if @search.sorts.empty?
      @pagy, @subscribers = pagy(@search.result.includes(included_resources))
    end

    def new
      @subscriber = group.subscribers.new
    end

    def create
      @subscriber = group.subscribers.new(subscriber_params)

      if @subscriber.save
        redirect_to coaching_group_subscribers_path(group),
                    flash: { success: t("flash_messages.created", name: "Subscriber") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      subscriber.destroy
      redirect_to coaching_group_subscribers_path(group),
                  status: :see_other,
                  flash: { danger: t("flash_messages.deleted",
                                     name: "Subscriber") }
    end

    private

    def subscriber_params
      params.require(:subscriber).permit(:student_id)
    end

    def group
      @group ||= current_account.groups.find(params[:group_id])
    end

    def subscriber
      @subscriber ||= group.subscribers.find(params[:id])
    end

    def included_resources
      [{ student: %i[client_type course] }, :created_by]
    end
  end
end
