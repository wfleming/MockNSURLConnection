PROJECT = "MockNSURLConnection"
CONFIGURATION = "Release"
FRAMEWORK_TARGET = "MockNSURLConnection-OSX"
IOS_FRAMEWORK_TARGET = "MockNSURLConnection-iOS"

PROJECT_ROOT = File.dirname(__FILE__)
BUILD_DIR = File.join(PROJECT_ROOT, "build")

def system_or_exit(cmd, stdout = nil)
  puts "Executing #{cmd}"
  cmd += " >#{stdout}" if stdout
  system(cmd) or raise "******** Build failed ********"
end

task :default => ["frameworks"]

desc "Clean all targets"
task :clean do
  system_or_exit "rm -rf #{BUILD_DIR}/*"
end

desc "Build frameworks"
task :frameworks do
  system_or_exit "xcodebuild -project #{PROJECT}.xcodeproj -target #{FRAMEWORK_TARGET} -configuration #{CONFIGURATION} build SYMROOT=#{BUILD_DIR}"
  system_or_exit "xcodebuild -project #{PROJECT}.xcodeproj -target #{IOS_FRAMEWORK_TARGET} -configuration #{CONFIGURATION} build SYMROOT=#{BUILD_DIR}"
end
