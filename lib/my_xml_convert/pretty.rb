require 'rexml/document'

module MyXmlConvert
  class Pretty

    DEFAULT_INDENT = 3
    DEFAULT_COMPACT = true

    public

      def self.prettify(xml, options = {})
        compact = options[:compact].nil? ? DEFAULT_COMPACT : options[:compact]
        indent = options[:indent] || DEFAULT_INDENT
        xmlstring = xml_prettify(xml, indent, compact)
        return xmlstring
      end

    private

      def self.xml_prettify(xml, indent, compact)
        result = ''
        formatter = REXML::Formatters::Pretty.new indent
        formatter.compact = compact
        doc = REXML::Document.new xml
        formatter.write doc, result
        return result
      end

  end
end
