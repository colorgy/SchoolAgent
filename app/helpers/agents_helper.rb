module AgentsHelper
  def agent_path_from_module module_name
    m = module_name.match(/(.+?)Agent/)
    agent_path(m[1])
  end
end
