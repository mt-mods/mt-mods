badly_formatted = {}
badly_formatted.test_function = function(string) if string then return string end end
badly_formatted.test_table = {data = "string", data2 = 1, data3 = {data1 = "string", data2 = 1, data3 = function(table) return table.tostring() end}}
for _, data in pairs(badly_formatted.test_table) do
	badly_formatted.test_function(data)
	badly_formatted.test_table.data3.data3(data)
end
