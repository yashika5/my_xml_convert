module MyXmlConvert
        class Fixnum

                def self.fixnum_to_xml(name="",obj, options = {})
                        xmlstring = ""
                        xmlstring = xmlstring + "<" + name + ">" if name
                        xmlstring = xmlstring + obj.to_s
                        xmlstring = xmlstring + "</" + name + ">" if name
                        return xmlstring
                end

        end
end

