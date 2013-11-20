namespace :cache do
desc "Deletes cache files"
  task :clean do
    count = Dir.glob('./public/cache/*.png').length
    signs = Dir.glob('./public/cache/*.png').each { |f| File.delete(f) }
    puts  "#{count} Images deleted"
  end
end
