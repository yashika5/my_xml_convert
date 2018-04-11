require "my_xml_convert/value"
require "my_xml_convert/key"

module MyXmlConvert
        class Array

                def self.array_to_xml(name,obj, options = {} )
                        xmlstring=""
                        for i in obj do

                                key = name || "array"
                                value = MyXmlConvert::Value.create(key,i,options)

                                xmlstring+= "<" + key + ">" + value + "</" + key + ">"

                        end
                        return xmlstring
                end
        end
end
