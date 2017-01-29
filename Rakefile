# luaenv specific setting
ENV['LUAENV_ROOT']="#{ENV['HOME']}/.luaenv"
LUAENV_EXEC="exec #{ENV['LUAENV_ROOT']}/libexec/luaenv exec"

TARGET = "algo"
LUA = ENV['LUA'] || "luajit"
LUAFLAGS = "-lalgo"
LUAROCKS = ENV['LUAROCKS'] || "luarocks"
ROCKSPEC = "algo-0.1.0-1.rockspec"
LDOC = "ldoc"
DOC_DIR = "doc"
TEST_DIR = "test"
RM = "rm"
RMFLAGS = "-rf"

task 'test' => [:install] do
  Dir.glob(File.join("**", "test", "*.lua")).each do |t|
      sh "#{LUAENV_EXEC} #{LUA} #{LUAFLAGS} #{t}"
  end
end

task 'install' => [:doc] do
  sh "#{LUAENV_EXEC} #{LUAROCKS} make #{ROCKSPEC}"
end

task 'uninstall' do
  begin
    sh "#{LUAENV_EXEC} #{LUAROCKS} remove #{TARGET} --force"
  rescue
    # Do nothing even the task failed
  end
end

task 'doc' do
  sh "#{LDOC}", "."
end

task 'clean' do
  sh "make clean"
end
