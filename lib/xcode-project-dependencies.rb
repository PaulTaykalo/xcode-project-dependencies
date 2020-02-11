#!/usr/bin/ruby
#encoding: utf-8
require 'xcodeproj'
require_relative 'stringcolors'
require 'fileutils'
require 'json'

class XcodeDependenciesFetcher

  def initialize(options)
    @root_path = options[:root_path] || ''
  end

  def fetch_dependencies(xcodeproj_path)
    begin
      project = Xcodeproj::Project.open(xcodeproj_path)
    rescue Exception => e
      STDERR.puts '[???]'.yellow + " There were some problems in opening #{xcodeproj_path} : #{e.to_s}"
      return []
    end

    links = []
    project.targets.each do |target|
      target_name = target.name
      unless target_name.end_with?("Tests")
        target.dependencies.each do |dep|
          dep_name = dep.name
          if dep_name == "" || dep_name.nil?
            # For dependencies withing the same project, we can target name
            dep_name = dep.target.name unless dep.target.nil?
          end  
          links += [{source: target_name, dest: dep_name}]
        end  
      end
    end  
    return links

  end

  def fetch_dependecies_from_all_projects

    all_links = []
    Dir.chdir(@root_path) {
      all_xcode_projects = Dir.glob('**/*.xcodeproj').reject {|path| !File.directory?(path)}
      all_xcode_projects.each {|xcodeproj|
        puts "Fetching dependencies from to #{xcodeproj.green}"
        all_links += fetch_dependencies(xcodeproj)
      }
    }
    deptree = {
      :links =>  all_links
    }
    puts "#{deptree.to_json}"
  end

end
