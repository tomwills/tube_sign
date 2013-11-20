namespace :cache do
desc "Deletes cache files"
  task :clean do
    signs = Dir.glob('./public/cache/*.png').each { |f| File.delete(f) }
    puts signs.size + " Images deleted"
  end
end
