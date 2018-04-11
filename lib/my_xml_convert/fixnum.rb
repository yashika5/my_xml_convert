module MyXmlConvert
        class Fixnum

                def self.fixnum_to_xml(name,obj, options = {})
                        xmlstring = ""
                        xmlstring = xmlstring + obj.to_s
                        return xmlstring
                end

        end
end

