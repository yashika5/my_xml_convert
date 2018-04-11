module MyXmlConvert
	class ObjtoXML

		public

			def self.to_xml(name,item) 

				xmlstring = "<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n"
				indent = 3;
				if item.is_a?(Hash)
					xmlstring+= "<Hash>\n"
					xmlstring+= "<"+name+">\n"
					xmlstring+= hash_to_xml(name,item,indent)
					xmlstring+= "</"+name+">\n"
					xmlstring+= "</Hash>\"\n"
				end
				if item.is_a?(Array)
					xmlstring+= "<Array>\n"
					xmlstring+= "<"+name+">\n"
					xmlstring+= array_to_xml(name,item,indent)
					xmlstring+= "</"+name+">\n"
					xmlstring+= "</Array>\"\n"
				end
				if item.is_a?(String)
					xmlstring+= "<String>\n"
					xmlstring+= "<"+name+">\n"
					xmlstring+=string_to_xml(name,item,indent)
					xmlstring+= "</"+name+">\n"
					xmlstring+= "</String>\"\n"
				end
				if item.is_a?(Fixnum)
					xmlstring+= "<Fixnum>\n"
					xmlstring+= "<"+name+">\n"
					xmlstring+=fixnum_to_xml(name,item,indent)
					xmlstring+= "</"+name+">\n"
					xmlstring+= "</Fixnum>\"\n"
				end
				return xmlstring

			end

		private
			def self.hash_to_xml(name,book,indent)
				xmlstring=""
				for i in book.keys do

					
					if book[i].is_a?(Fixnum)
						xmlstring+=fixnum_to_xml(i,book[i],indent)
					end
					if book[i].is_a?(String)
						xmlstring+=string_to_xml(i,book[i],indent)
					end
					if book[i].is_a?(Array)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "<" + i + ">"
						xmlstring+="\n"
						aindent=indent+3
						xmlstring+=array_to_xml(i,book[i],aindent)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "</" + i + ">\n"
					end
					if book[i].is_a?(Hash)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "<" + i + ">"
						xmlstring+="\n"
						hindent=indent+3;
						xmlstring+=hash_to_xml(i,book[i],hindent)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "</" + i + ">\n"
					end
					
				end
				return xmlstring
			end

			def self.array_to_xml(name,book,indent)
				xmlstring=""
				for i in book do
					
					if i.is_a?(Fixnum)
						xmlstring+=fixnum_to_xml(name,i,indent)
					end
					if i.is_a?(String)
						xmlstring+=string_to_xml(name,i,indent)
					end
					if i.is_a?(Array)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "<" + name + ">"
						xmlstring+="\n"
						aindent=indent+3;
						xmlstring+=array_to_xml(name,i,aindent)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "</" + name + ">\n"
					end
					if i.is_a?(Hash)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "<" + name + ">"
						xmlstring+="\n"
						hindent=indent+3;
						xmlstring+=hash_to_xml(name,i,hindent)
						indent.times { xmlstring+=" " }
						xmlstring = xmlstring + "</" + name + ">\n"
					end
				end
				return xmlstring
			end

			def self.string_to_xml(name,item,indent)
				xmlstring = ""
				indent.times { xmlstring+=" " }
				xmlstring = xmlstring + "<" + name + ">" + item + "</" + name + ">\n"
				return xmlstring
			end

			def self.fixnum_to_xml(name,item,indent)
				xmlstring = ""
				indent.times { xmlstring+=" " }
				xmlstring = xmlstring + "<" + name + ">" + item.to_s + "</" + name + ">\n"
				return xmlstring
			end

	end
end