module MyXmlConvert
  module Key
    class << self

      public

      CAMELCASE       = lambda { |key| key.split('_').collect(&:capitalize).join }
      LOWER_CAMELCASE = lambda { |key| key[0].chr.downcase + CAMELCASE.call(key)[1..-1] }
      UPCASE          = lambda { |key| key.upcase }

      FORMULAS = {
        :lower_camelcase => lambda { |key| LOWER_CAMELCASE.call(key) },
        :camelcase       => lambda { |key| CAMELCASE.call(key) },
        :upcase          => lambda { |key| UPCASE.call(key) },
        :none            => lambda { |key| key }
      }

      # Converts a given key with options to an XML key.
      def create(key, options = {})
        xml_key = chop_special_characters key.to_s

        if symbol = isSymbol?(xml_key)
          xml_key = xml_key.split(":").last
        end

        a = key_converter(options, xml_key)
        xml_key = a.call(xml_key) if Symbol === key

        return xml_key
      end

      private

        # Returns the formula for converting Symbol keys into specified format.
        def key_converter(options, xml_key)
          return options[:key_converter] if options[:key_converter].is_a? Proc

          defined_key = options[:key_to_convert]
          if (defined_key != nil) && (defined_key == xml_key)
            key_converter = options[:key_converter]
          elsif defined_key != nil
            key_converter = :lower_camelcase
          elsif (options[:except] == xml_key)
            key_converter = :lower_camelcase
          else
            key_converter = options[:key_converter] || :lower_camelcase
          end
          FORMULAS[key_converter]
        end

        # Chops special characters from the end of a given string.
        def chop_special_characters(string)
          ["!", "/"].include?(string[-1,1]) ? string.chop : string
        end

        # Returns whether key is string or symbol.
        def isSymbol?(key)
          key[0, 1] == ":"
        end

    end
  end
end
