class AgentsController < ApplicationController
  layout "agent"

  def index
    @agents = Agent.agent_list.sort_by {|c| c.name.demodulize }
    respond_to do |format|
      format.html
      format.json { render :json => Agent.agent_name_list }
    end
  end

  def show
    @agent_class = Agent.agent_class(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => {login_fields: @agent_class::LOGIN_FIELDS } }
    end
  end
end
