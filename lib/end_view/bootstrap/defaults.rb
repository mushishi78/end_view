require 'end_view/form/defaults'
require 'haml/helpers'

module EndView
  module Bootstrap
    class Defaults < Form::Defaults
      class << self
        def email
          @email ||= add_icon(super, 'envelope')
        end

        def phone
          @phone ||= add_icon(super, 'earphone')
        end

        def password
          @password ||= add_icon(super, 'lock')
        end

        def card
          @card ||= add_icon(super, 'credit-card')
        end

        private

        def add_icon(default, icon_name)
          [default[0], default[1].merge(left: icon(icon_name))]
        end

        def icon(icon)
          "<span class='glyphicon glyphicon-#{icon}' aria-hidden='true'></span>"
        end
      end
    end
  end
end
