module MyXmlConvert
        class Fixnum

                def self.fixnum_to_xml(obj, options = {})
                        xmlstring = ""
                        xmlstring = xmlstring + "<" + options[:name] + ">" if options[:name]
                        xmlstring = xmlstring + obj.to_s
                        xmlstring = xmlstring + "</" + options[:name] + ">" if options[:name]
                        return xmlstring
                end

        end
end

