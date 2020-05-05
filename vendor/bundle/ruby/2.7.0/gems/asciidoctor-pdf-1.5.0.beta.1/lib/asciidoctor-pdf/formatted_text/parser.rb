# regenerate parser.rb using `tt parser.treetop`
# Autogenerated from a Treetop grammar. Edits may be lost.


module Asciidoctor
module PDF
module FormattedText
module Markup
  include Treetop::Runtime

  def root
    @root ||= :text
  end

  def _nt_text
    start_index = index
    if node_cache[:text].has_key?(index)
      cached = node_cache[:text][index]
      if cached
        node_cache[:text][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_complex

    node_cache[:text][start_index] = r0

    r0
  end

  module Complex0
    def content
      elements.map {|e| e.content }
    end
  end

  def _nt_complex
    start_index = index
    if node_cache[:complex].has_key?(index)
      cached = node_cache[:complex][index]
      if cached
        node_cache[:complex][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1 = index
      r2 = _nt_cdata
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r1 = r2
      else
        r3 = _nt_element
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r1 = r3
        else
          r4 = _nt_charref
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r1 = r4
          else
            @index = i1
            r1 = nil
          end
        end
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    r0.extend(Complex0)

    node_cache[:complex][start_index] = r0

    r0
  end

  module Element0
    def start_tag
      elements[0]
    end

    def complex
      elements[1]
    end

    def end_tag
      elements[2]
    end
  end

  module Element1
    # NOTE content only applies to non-void elements (second part of rule)
    def content
      { type: :element, name: (tag_element = elements[0]).name.to_sym, attributes: tag_element.attributes, pcdata: elements[1].content }
    end
  end

  def _nt_element
    start_index = index
    if node_cache[:element].has_key?(index)
      cached = node_cache[:element][index]
      if cached
        node_cache[:element][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_void_element
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      i2, s2 = index, []
      r3 = _nt_start_tag
      s2 << r3
      if r3
        r4 = _nt_complex
        s2 << r4
        if r4
          r5 = _nt_end_tag
          s2 << r5
        end
      end
      if s2.last
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
        r2.extend(Element0)
        r2.extend(Element1)
      else
        @index = i2
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:element][start_index] = r0

    r0
  end

  module VoidElement0
  end

  module VoidElement1
    def void_tag_name
      elements[1]
    end

    def attributes
      elements[2]
    end

  end

  module VoidElement2
    def content
      { type: :element, name: elements[1].text_value.to_sym, attributes: elements[2].content }
    end
  end

  def _nt_void_element
    start_index = index
    if node_cache[:void_element].has_key?(index)
      cached = node_cache[:void_element][index]
      if cached
        node_cache[:void_element][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?('<', false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('<')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_void_tag_name
      s0 << r2
      if r2
        r3 = _nt_attributes
        s0 << r3
        if r3
          i5, s5 = index, []
          r7 = _nt_spaces
          if r7
            r6 = r7
          else
            r6 = instantiate_node(SyntaxNode,input, index...index)
          end
          s5 << r6
          if r6
            if (match_len = has_terminal?('/', false, index))
              r8 = true
              @index += match_len
            else
              terminal_parse_failure('/')
              r8 = nil
            end
            s5 << r8
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(VoidElement0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            r4 = r5
          else
            r4 = instantiate_node(SyntaxNode,input, index...index)
          end
          s0 << r4
          if r4
            if (match_len = has_terminal?('>', false, index))
              r9 = true
              @index += match_len
            else
              terminal_parse_failure('>')
              r9 = nil
            end
            s0 << r9
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(VoidElement1)
      r0.extend(VoidElement2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:void_element][start_index] = r0

    r0
  end

  module StartTag0
    def tag_name
      elements[1]
    end

    def attributes
      elements[2]
    end

  end

  module StartTag1
    def name
      elements[1].text_value
    end

    def attributes
      elements[2].content
    end
  end

  def _nt_start_tag
    start_index = index
    if node_cache[:start_tag].has_key?(index)
      cached = node_cache[:start_tag][index]
      if cached
        node_cache[:start_tag][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?('<', false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('<')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_tag_name
      s0 << r2
      if r2
        r3 = _nt_attributes
        s0 << r3
        if r3
          if (match_len = has_terminal?('>', false, index))
            r4 = true
            @index += match_len
          else
            terminal_parse_failure('>')
            r4 = nil
          end
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(StartTag0)
      r0.extend(StartTag1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:start_tag][start_index] = r0

    r0
  end

  def _nt_tag_name
    start_index = index
    if node_cache[:tag_name].has_key?(index)
      cached = node_cache[:tag_name][index]
      if cached
        node_cache[:tag_name][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?('a', false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('a')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      if (match_len = has_terminal?('strong', false, index))
        r2 = instantiate_node(SyntaxNode,input, index...(index + match_len))
        @index += match_len
      else
        terminal_parse_failure('strong')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        if (match_len = has_terminal?('em', false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('em')
          r3 = nil
        end
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          if (match_len = has_terminal?('code', false, index))
            r4 = instantiate_node(SyntaxNode,input, index...(index + match_len))
            @index += match_len
          else
            terminal_parse_failure('code')
            r4 = nil
          end
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
          else
            if (match_len = has_terminal?('color', false, index))
              r5 = instantiate_node(SyntaxNode,input, index...(index + match_len))
              @index += match_len
            else
              terminal_parse_failure('color')
              r5 = nil
            end
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
            else
              if (match_len = has_terminal?('font', false, index))
                r6 = instantiate_node(SyntaxNode,input, index...(index + match_len))
                @index += match_len
              else
                terminal_parse_failure('font')
                r6 = nil
              end
              if r6
                r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
                r0 = r6
              else
                if (match_len = has_terminal?('span', false, index))
                  r7 = instantiate_node(SyntaxNode,input, index...(index + match_len))
                  @index += match_len
                else
                  terminal_parse_failure('span')
                  r7 = nil
                end
                if r7
                  r7 = SyntaxNode.new(input, (index-1)...index) if r7 == true
                  r0 = r7
                else
                  if (match_len = has_terminal?('button', false, index))
                    r8 = instantiate_node(SyntaxNode,input, index...(index + match_len))
                    @index += match_len
                  else
                    terminal_parse_failure('button')
                    r8 = nil
                  end
                  if r8
                    r8 = SyntaxNode.new(input, (index-1)...index) if r8 == true
                    r0 = r8
                  else
                    if (match_len = has_terminal?('sub', false, index))
                      r9 = instantiate_node(SyntaxNode,input, index...(index + match_len))
                      @index += match_len
                    else
                      terminal_parse_failure('sub')
                      r9 = nil
                    end
                    if r9
                      r9 = SyntaxNode.new(input, (index-1)...index) if r9 == true
                      r0 = r9
                    else
                      if (match_len = has_terminal?('sup', false, index))
                        r10 = instantiate_node(SyntaxNode,input, index...(index + match_len))
                        @index += match_len
                      else
                        terminal_parse_failure('sup')
                        r10 = nil
                      end
                      if r10
                        r10 = SyntaxNode.new(input, (index-1)...index) if r10 == true
                        r0 = r10
                      else
                        if (match_len = has_terminal?('del', false, index))
                          r11 = instantiate_node(SyntaxNode,input, index...(index + match_len))
                          @index += match_len
                        else
                          terminal_parse_failure('del')
                          r11 = nil
                        end
                        if r11
                          r11 = SyntaxNode.new(input, (index-1)...index) if r11 == true
                          r0 = r11
                        else
                          @index = i0
                          r0 = nil
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    node_cache[:tag_name][start_index] = r0

    r0
  end

  def _nt_void_tag_name
    start_index = index
    if node_cache[:void_tag_name].has_key?(index)
      cached = node_cache[:void_tag_name][index]
      if cached
        node_cache[:void_tag_name][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?('br', false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('br')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      if (match_len = has_terminal?('img', false, index))
        r2 = instantiate_node(SyntaxNode,input, index...(index + match_len))
        @index += match_len
      else
        terminal_parse_failure('img')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:void_tag_name][start_index] = r0

    r0
  end

  module Attributes0
    def content
      attrs = {}
      elements.each {|e|
        attr_name, attr_val = e.content
        attrs[attr_name.to_sym] = attr_val
      }
      attrs
    end
  end

  def _nt_attributes
    start_index = index
    if node_cache[:attributes].has_key?(index)
      cached = node_cache[:attributes][index]
      if cached
        node_cache[:attributes][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_attribute
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    r0.extend(Attributes0)

    node_cache[:attributes][start_index] = r0

    r0
  end

  module Attribute0
    def spaces
      elements[0]
    end

  end

  module Attribute1
    def content
      [elements[1].text_value, elements[4].text_value]
    end
  end

  def _nt_attribute
    start_index = index
    if node_cache[:attribute].has_key?(index)
      cached = node_cache[:attribute][index]
      if cached
        node_cache[:attribute][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_spaces
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[a-z_]'] ||= Regexp.new(gr), :regexp, index)
          r3 = true
          @index += 1
        else
          terminal_parse_failure('[a-z_]')
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
      if r2
        if (match_len = has_terminal?('=', false, index))
          r4 = true
          @index += match_len
        else
          terminal_parse_failure('=')
          r4 = nil
        end
        s0 << r4
        if r4
          if (match_len = has_terminal?('"', false, index))
            r5 = true
            @index += match_len
          else
            terminal_parse_failure('"')
            r5 = nil
          end
          s0 << r5
          if r5
            s6, i6 = [], index
            loop do
              if has_terminal?(@regexps[gr = '\A[^"]'] ||= Regexp.new(gr), :regexp, index)
                r7 = true
                @index += 1
              else
                terminal_parse_failure('[^"]')
                r7 = nil
              end
              if r7
                s6 << r7
              else
                break
              end
            end
            r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
            s0 << r6
            if r6
              if (match_len = has_terminal?('"', false, index))
                r8 = true
                @index += match_len
              else
                terminal_parse_failure('"')
                r8 = nil
              end
              s0 << r8
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Attribute0)
      r0.extend(Attribute1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:attribute][start_index] = r0

    r0
  end

  module EndTag0
    def tag_name
      elements[1]
    end

  end

  module EndTag1
    def name
      elements[1].text_value
    end
  end

  def _nt_end_tag
    start_index = index
    if node_cache[:end_tag].has_key?(index)
      cached = node_cache[:end_tag][index]
      if cached
        node_cache[:end_tag][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?('</', false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('</')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_tag_name
      s0 << r2
      if r2
        if (match_len = has_terminal?('>', false, index))
          r3 = true
          @index += match_len
        else
          terminal_parse_failure('>')
          r3 = nil
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(EndTag0)
      r0.extend(EndTag1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:end_tag][start_index] = r0

    r0
  end

  module Cdata0
    def content
      { type: :text, value: text_value }
    end
  end

  def _nt_cdata
    start_index = index
    if node_cache[:cdata].has_key?(index)
      cached = node_cache[:cdata][index]
      if cached
        node_cache[:cdata][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[^<&]'] ||= Regexp.new(gr), :regexp, index)
        r1 = true
        @index += 1
      else
        terminal_parse_failure('[^<&]')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Cdata0)
    end

    node_cache[:cdata][start_index] = r0

    r0
  end

  module Charref0
    def character_decimal
      elements[1]
    end
  end

  module Charref1
    def character_hex
      elements[1]
    end
  end

  module Charref2
  end

  module Charref3
    def content
      if (ref_data = elements[1]).terminal?
        { type: :charref, reference_type: :name, value: ref_data.text_value.to_sym }
      elsif ref_data.elements[0].text_value == '#'
        { type: :charref, reference_type: :decimal, value: ref_data.elements[1].text_value.to_i }
      else
        { type: :charref, reference_type: :hex, value: ref_data.elements[1].text_value }
      end
    end
  end

  def _nt_charref
    start_index = index
    if node_cache[:charref].has_key?(index)
      cached = node_cache[:charref][index]
      if cached
        node_cache[:charref][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?('&', false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('&')
      r1 = nil
    end
    s0 << r1
    if r1
      i2 = index
      i3, s3 = index, []
      if (match_len = has_terminal?('#', false, index))
        r4 = true
        @index += match_len
      else
        terminal_parse_failure('#')
        r4 = nil
      end
      s3 << r4
      if r4
        r5 = _nt_character_decimal
        s3 << r5
      end
      if s3.last
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        r3.extend(Charref0)
      else
        @index = i3
        r3 = nil
      end
      if r3
        r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
        r2 = r3
      else
        i6, s6 = index, []
        if (match_len = has_terminal?('#x', false, index))
          r7 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('#x')
          r7 = nil
        end
        s6 << r7
        if r7
          r8 = _nt_character_hex
          s6 << r8
        end
        if s6.last
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          r6.extend(Charref1)
        else
          @index = i6
          r6 = nil
        end
        if r6
          r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
          r2 = r6
        else
          r9 = _nt_character_name
          if r9
            r9 = SyntaxNode.new(input, (index-1)...index) if r9 == true
            r2 = r9
          else
            @index = i2
            r2 = nil
          end
        end
      end
      s0 << r2
      if r2
        if (match_len = has_terminal?(';', false, index))
          r10 = true
          @index += match_len
        else
          terminal_parse_failure(';')
          r10 = nil
        end
        s0 << r10
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Charref2)
      r0.extend(Charref3)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:charref][start_index] = r0

    r0
  end

  def _nt_character_decimal
    start_index = index
    if node_cache[:character_decimal].has_key?(index)
      cached = node_cache[:character_decimal][index]
      if cached
        node_cache[:character_decimal][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[0-9]'] ||= Regexp.new(gr), :regexp, index)
        r1 = true
        @index += 1
      else
        terminal_parse_failure('[0-9]')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
      if s0.size == 6
        break
      end
    end
    if s0.size < 2
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:character_decimal][start_index] = r0

    r0
  end

  def _nt_character_hex
    start_index = index
    if node_cache[:character_hex].has_key?(index)
      cached = node_cache[:character_hex][index]
      if cached
        node_cache[:character_hex][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[0-9a-f]'] ||= Regexp.new(gr), :regexp, index)
        r1 = true
        @index += 1
      else
        terminal_parse_failure('[0-9a-f]')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
      if s0.size == 5
        break
      end
    end
    if s0.size < 2
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:character_hex][start_index] = r0

    r0
  end

  def _nt_character_name
    start_index = index
    if node_cache[:character_name].has_key?(index)
      cached = node_cache[:character_name][index]
      if cached
        node_cache[:character_name][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?('amp', false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('amp')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      if (match_len = has_terminal?('apos', false, index))
        r2 = instantiate_node(SyntaxNode,input, index...(index + match_len))
        @index += match_len
      else
        terminal_parse_failure('apos')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        if (match_len = has_terminal?('gt', false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('gt')
          r3 = nil
        end
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          if (match_len = has_terminal?('lt', false, index))
            r4 = instantiate_node(SyntaxNode,input, index...(index + match_len))
            @index += match_len
          else
            terminal_parse_failure('lt')
            r4 = nil
          end
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
          else
            if (match_len = has_terminal?('nbsp', false, index))
              r5 = instantiate_node(SyntaxNode,input, index...(index + match_len))
              @index += match_len
            else
              terminal_parse_failure('nbsp')
              r5 = nil
            end
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
            else
              if (match_len = has_terminal?('quot', false, index))
                r6 = instantiate_node(SyntaxNode,input, index...(index + match_len))
                @index += match_len
              else
                terminal_parse_failure('quot')
                r6 = nil
              end
              if r6
                r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
                r0 = r6
              else
                @index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:character_name][start_index] = r0

    r0
  end

  def _nt_spaces
    start_index = index
    if node_cache[:spaces].has_key?(index)
      cached = node_cache[:spaces][index]
      if cached
        node_cache[:spaces][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if (match_len = has_terminal?(' ', false, index))
        r1 = true
        @index += match_len
      else
        terminal_parse_failure(' ')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:spaces][start_index] = r0

    r0
  end

end

class MarkupParser < Treetop::Runtime::CompiledParser
  include Markup
end

end
end
end
