require "date"
require "my_xml_convert/hash"
require "my_xml_convert/array"
require "my_xml_convert/string"
require "my_xml_convert/fixnum"

module MyXmlConvert
  module Value
    class << self

      # xs:date format
      XS_DATE_FORMAT = "%Y-%m-%d"

      # xs:time format
      XS_TIME_FORMAT = "%H:%M:%S"

      # xs:dateTime format
      XS_DATETIME_FORMAT = "%Y-%m-%dT%H:%M:%S%Z"

      # Converts a given value to an XML value.
      def create(name,object, options = {} )
        if DateTime === object
          object.strftime XS_DATETIME_FORMAT

        elsif Time === object
          object.strftime XS_TIME_FORMAT

        elsif Date === object
          object.strftime XS_DATE_FORMAT

        elsif ::String === object
          puts "correct"
          MyXmlConvert::String.string_to_xml(name,object, options)
        
        elsif ::Hash === object
          MyXmlConvert::Hash.hash_to_xml(name,object, options)

        elsif ::Array === object
          MyXmlConvert::Array.array_to_xml(name,object, options)

	      elsif ::Fixnum === object
          MyXmlConvert::Fixnum.fixnum_to_xml(name,object, options)

        else
          object.to_s
        end
      
      end

    end
  end
end
