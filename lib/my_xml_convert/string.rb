require "cgi"

module MyXmlConvert
	class String

		def self.string_to_xml(obj, options = {})
			xmlstring = ""
			escape_xml = options[:escape_xml]
			obj = escape_xml ? CGI.escapeHTML(obj) : obj
			xmlstring = xmlstring + "<" + options[:name] + ">" if options[:name]
			xmlstring = xmlstring + obj 
			xmlstring = xmlstring + "</" + options[:name] + ">" if options[:name]
			return xmlstring
		end

	end
end
