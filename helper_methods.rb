  def add8192(x)
     x = x + 8192
  end

  def subtr8192(x)
     x = x - 8192
  end

  def transformDecToHex(x)
      hex = x.to_s(16)
  end

  def transformDecToBin(x)
      bin = x.to_s(2)
  end

  def transformBinToDec(x)
      x.to_i(2)
  end

  def transformBinToHex(x)
      "%02x" % x.to_i(2)
  end

  def transformHexToBin(num)
      num.hex.to_s(2).rjust(num.size*4, '0')
  end

  def makeOnePackedByte(x)
      x = '0' * (8-x.length) + x if x.length < 8
      return x
  end

  def makeTwoPackedBytes(x)
      x = '0' * (16-x.length) + x if x.length < 16
      return x
  end

  def splitIntoBytes(x)
     return x[0,8], x[8,15]
  end

  def packBytes(x, y)
      yMSB = y[0]
      y[0] = '0'
      xDec = x.to_i(2) # transform binary to decimal for shift
      xDec = (xDec << 1).to_s(2) # shift bits to the left by one
      x = xDec
      x = makeOnePackedByte(x)
      x[7] = yMSB
      x[0] = '0'
      return x, y
  end

  def unpackBytes(x, y)
      xLSB = x[7] # grab LSB from x
      x[7] = ''
      y[0] = '0' # clear yMSB bit
      y[0] = xLSB
      x = makeOnePackedByte(x)
      xDec = x.to_i(2) # transform binary to decimal for shift
      xDec = (xDec >> 1).to_s(2) # shift bits to the right by one
      return x,y
  end

  def encode(val)
    x, y = splitIntoBytes( makeTwoPackedBytes( transformDecToBin( add8192(val) ) ) )
    h, l = packBytes(x, y)
    encoded = transformBinToHex(h+l)
    encoded = '0' * (4-encoded.length) + encoded if encoded.length < 4
    return encoded
  end

  def decode(*args)
    if args.size == 1 # Method works for input in the form of '7f7f' or '7f','7f'
      a = args[0][0..1]
      b = args[0][2..3]
    else
      a = args[0]
      b = args[1]
    end
    binStr = transformHexToBin(a+b)
    x, y = splitIntoBytes(binStr)
    a, b = unpackBytes(x,y)
    c = transformBinToDec(a+b)
    decoded = subtr8192(c).to_s
    decoded = '0' * (4-decoded.length) + decoded if decoded.length < 4
    return decoded
  end
