require "spec_helper"

describe MyXmlConvert::Key do

  describe ".create" do
    it "removes exclamation marks from the end of a String" do
      expect(MyXmlConvert::Key.create("value!")).to eq("value")
    end

    it "removes forward slashes from the end of a String" do
      expect(MyXmlConvert::Key.create("self-closing/")).to eq("self-closing")
    end

    it "does not convert snake_case Strings" do
      expect(MyXmlConvert::Key.create("lower_camel_case")).to eq("lower_camel_case")
    end

    it "converts snake_case Symbols to lowerCamelCase Strings" do
      expect(MyXmlConvert::Key.create(:lower_camel_case)).to eq("lowerCamelCase")
      expect(MyXmlConvert::Key.create(:lower_camel_case!)).to eq("lowerCamelCase")
    end

    context "when the converter option is set to camelcase" do
      it "should replace snake case into camel case" do
        input = "hello_world_bob/how_are_you|there:foo^bar".to_sym
        expected_output = "HelloWorldBob/howAreYou|there:foo^bar"
        expect(MyXmlConvert::Key.create(input, {key_converter: :camelcase})).to eq(expected_output)
      end
    end

    context "with key_converter" do
      it "accepts lambda converters" do
        expect(MyXmlConvert::Key.create(:some_text, {key_converter: lambda { |k| k.reverse }})).to eq("txet_emos")
      end

      it "convert symbol to the specified type" do
        expect(MyXmlConvert::Key.create(:some_text, {key_converter: :camelcase})).to eq("SomeText")
        expect(MyXmlConvert::Key.create(:some_text, {key_converter: :upcase})).to eq("SOME_TEXT")
        expect(MyXmlConvert::Key.create(:some_text, {key_converter: :none})).to eq("some_text")
      end

      it "when key_to_convert is defined, convert only this key" do
        options = {key_converter: :camelcase, key_to_convert: 'somekey'}
        expect(MyXmlConvert::Key.create(:some_key, options)).to eq("someKey")

        options = {key_converter: :camelcase, key_to_convert: 'some_key'}
        expect(MyXmlConvert::Key.create(:some_key, options)).to eq("SomeKey")
      end

      it "when except is defined, don't convert this key" do
        options = {key_converter: :camelcase, except: 'some_key'}
        expect(MyXmlConvert::Key.create(:some_key, options)).to eq("someKey")
      end
    end
    
  end

end
