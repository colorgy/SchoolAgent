require_relative './mixins'

module Agent
  class Base
    include Mixins

    def login; raise MethodNotImplement; end
    def fetch; raise MethodNotImplement; end

  end
end
