require "my_xml_convert/value"
require "my_xml_convert/key"

module MyXmlConvert
        class Array

                def self.array_to_xml(obj, options = {} )
                        xmlstring=""
                        for i in obj do

                                key = options[:name] || "array"
                                value = MyXmlConvert::Value.create(i,options)

                                xmlstring+= "<" + key + ">" + value + "</" + key + ">"

                        end
                        return xmlstring
                end
        end
end
