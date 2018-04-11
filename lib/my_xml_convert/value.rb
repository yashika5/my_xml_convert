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
      def create(object, options = {} )
        if Date === object
          object.strftime XS_DATE_FORMAT

        elsif Time === object
          object.strftime XS_TIME_FORMAT

        elsif DateTime === object
          object.strftime XS_DATETIME_FORMAT

        elsif object.respond_to?(:to_datetime)
          create object.to_datetime

        elsif object.respond_to?(:call)
          create object.call

        elsif String === object
          MyXmlConvert::String.to_xml(object, options)
        
        elsif ::Hash === object
          MyXmlConvert::Hash.to_xml(object, options)

        elsif ::Array === object
          MyXmlConvert::Array.to_xml(object, options)

	elsif ::Fixnum === object
          MyXmlConvert::Fixnum.to_xml(object, options)

        else
          object.to_s
        end
      
      end

    end
  end
end
