class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    dummy = self.flatten
    total_byte_num = String.new
    dummy.each_with_index do |elem, index|
      if elem.is_a?(String)
        elem.each_byte do |byte|
          total_byte_num << (byte + index).to_s
        end
      else
        total_byte_num << (elem + index).to_s
      end
    end
    total_byte_num.to_i.hash
  end
end

class String
  def hash
    self.split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.map(&:to_s).sort.hash #self.values.hash
    #0
  end
end
