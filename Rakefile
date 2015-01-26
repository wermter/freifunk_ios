# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require :default
require 'bubble-wrap/location'
require 'bubble-wrap/reactor'

VERSION = "2.15.0"

Motion::Project::App.setup do |app|
  app.name                    = 'freifunk'
  app.archs['iPhoneOS']       |= ['arm64']
  app.device_family           = [:iphone, :ipad]
  app.deployment_target       = '7.0'
  app.icons                   = Dir['resources/Icon*'].map { |file| File.basename(file) }
  app.codesign_certificate    = 'iPhone Distribution: Peter Schroeder'
  app.identifier              = 'de.nofail.freifunk'
  
  app.frameworks += ['CoreLocation', 'MapKit']
  
  app.development do
    app.version                                   = "build #{%x(git describe --tags).chomp}"
    app.info_plist['CFBundleShortVersionString']  = VERSION
    app.provisioning_profile                      = "#{ENV['HOME']}/Dropbox/ios_certs/ad_hoc_distribution_freifunk.mobileprovision"

    app.entitlements['get-task-allow'] = false
  end

  app.release do
    app.version                                   = VERSION
    app.info_plist['CFBundleShortVersionString']  = "2.15.2"
    app.provisioning_profile                      = "#{ENV['HOME']}/Dropbox/ios_certs/freifunk_distribution.mobileprovision"
  end
end

desc "download latest node json"
task :nodes, [:name] do |t, args|
  require_relative 'app/01_models/region.rb'
  if name = args[:name]
    regions = [Region.find(name.to_sym)]
  else
    regions = Region.all
  end
  regions.each do |region|
    system("wget -O tmp.json '#{region.data_url}'")
    system("cat tmp.json | python -mjson.tool > resources/data/#{region.key}.json")
    system("rm tmp.json")
  end
end
