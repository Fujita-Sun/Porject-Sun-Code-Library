module PSCL
$xmlhead = '<?xml version="1.0" encoding="UTF-8"?>' + "\n"
def self.cls2s(cls)
	[Array,Hash,Fixnum,Float,String,Symbol,TrueClass,FalseClass,NilClass].each{|c|
		if cls.class == c then
			return nil
		end
	}
	output = sprintf("<class base=%s>\n",'"'+cls.class.to_s+'"')
	vararr = cls.instance_variables
	vararr.each{|evt|
		output += sprintf("<var name=%s>\n",'"'+evt.to_s+'"')
		if cls.instance_variable_get(evt).class == Array then
			output += arr2s(cls.instance_variable_get(evt))
		elsif cls.instance_variable_get(evt).class == Hash then
			output += hsh2s(cls.instance_variable_get(evt))
		elsif [Fixnum,Float,String,Symbol,TrueClass,FalseClass,NilClass].include?(cls.instance_variable_get(evt).class)
			output += cls.instance_variable_get(evt).to_s + "\n"
		else
			output += cls2s(cls.instance_variable_get(evt))
		end
		output += sprintf("</var>\n")
	}
	output += sprintf("</class>\n",cls.class.to_s)
	return output
end
def self.arr2s(arr)
	if arr.class != Array then 
		return nil
	end
	output = sprintf("<array>\n")
  ops = 0
	arr.each{|evt|
		output += sprintf("<a sub=%s>\n",'"'+ops.to_s+'"')
		if evt.class == Array then
			output += arr2s(evt)
		elsif evt.class == Hash then
			output += hsh2s(evt)
		elsif [Fixnum,Float,String,Symbol,TrueClass,FalseClass,NilClass].include?(evt.class)
			output += evt.to_s + "\n"
		else
			output += cls2s(evt)
		end
		output += sprintf("</a>\n")
    ops+=1
	}
	output += sprintf("</array>\n")
	return output;
end
def self.hsh2s(hsh)
	if hsh.class != Hash then 
		return nil
	end
	output = sprintf("<hash>\n")
	hsh.each{|key,value|
		output += sprintf("<h key=%s>\n",'"'+key.to_s+'"')
		if value.class == Array then
			output += arr2s(value)
		elsif value.class == Hash then
			output += hsh2s(value)
		elsif [Fixnum,Float,String,Symbol,TrueClass,FalseClass,NilClass].include?(value.class)
			output += value.to_s + "\n"
		else
			output += cls2s(value)
		end
		output += sprintf("</h>\n")
	}
	output += sprintf("</hash>\n")
	return output;
end
end
