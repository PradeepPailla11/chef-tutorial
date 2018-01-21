file 'default www' do
	path '/var/www/html/index.html'
	content 'Hello World!! Version 2.0'
end

webnode = search('node', 'role:web')

webnode.each do |node|
	puts node
end
