module Naturesoft
  module Areas
    class AreasController < Naturesoft::FrontendController
      def listing
        @main_areas = Naturesoft::Areas::Area.get_main_areas
      end
    end
  end
end