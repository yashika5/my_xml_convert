require "cgi"

module MyXmlConvert
	class String

		def self.string_to_xml(name="",obj, options = {})
			xmlstring = ""
			escape_xml = options[:escape_xml]
			obj = escape_xml ? CGI.escapeHTML(obj) : obj
			xmlstring = xmlstring + "<" + name + ">" if name
			xmlstring = xmlstring + obj 
			xmlstring = xmlstring + "</" + name + ">" if name
			return xmlstring
		end

	end
end
