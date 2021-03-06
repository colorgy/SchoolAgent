class ImportController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def import_course
    agent = Agent.agent_class.new # choose crawler according to user's organization
    agent.login(import_params)
    @course_codes = agent.fetch

    if !@course_codes.blank?
      @courses = CourseAPI.get_courses(@course_codes, current_user)
      CourseUpdateWorker.perform_async(@course_codes, current_user.id)
      render :result
    else
      if @course_codes.nil?
        flash[:error] = "發生錯誤，請稍候在重試"
      else
        flash[:warning] = "您沒有選課的資料哦"
      end
      redirect_to root_path
    end
  end

  private
    def import_params
      params.permit(:studentno, :idcard, :birthday, :password)
    end

end
