def tasaoasao(num,t)
  return tanh(asinh(acosh(asinh(acosh(num / t)))
end
def strhash(str,t,k)
  val = 0
  for i in 1..str.length
    val = (val * t + str[i]) % k
  end
  return  val
end
Dir::chdir("Patches")
pcfls = Dir::glob("*.rvdata2")
pcfls.each{|fl|
	check = Marshal.load(File.open(fl,"rb"))
	data = Marshal.load(File.open(fl,"rb"))
	if check.class != Array && data.class != Array
		return false
	end
	if tasaoasao(strhash(data[2],check[3],check[4]),check[2]) != check[1]
    return false
  end
  
}
