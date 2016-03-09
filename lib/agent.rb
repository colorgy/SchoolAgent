module Agent
  class AttributeNotDefined < StandardError; end

  class AgentNotFound < StandardError; end

  class << self
    def agent_class org_code=nil
      org_code = 'NTUST' if org_code.nil?

      sym = Agent.constants.find{|c| c.to_s.match(/#{org_code.capitalize}Agent/) }
      if !sym
        raise AgentNotFound
      else
        Agent.const_get(sym)
      end
    end

    def agent_name_list
      Agent.constants.select{|c| c.to_s.match(/.+?Agent/) }
    end

    def agent_list
      agent_name_list.map{|n| Agent.const_get(n) }
    end
  end
end

Dir.glob(File.join(File.dirname(__FILE__), 'agent/*.rb')) { |file| load file }
