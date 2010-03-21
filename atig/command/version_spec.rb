#! /opt/local/bin/ruby -w
# -*- mode:ruby; coding:utf-8 -*-

require 'atig/spec_helper'
require 'atig/command/version'
require 'atig/command/command_helper'

describe Atig::Command::Version do
  include CommandHelper

  def s(source)
    s = mock "status-#{source}"
    s.stub!(:source).and_return(source)
    s
  end

  before do
    @command = init Atig::Command::Version
    @status  = stub "status"
    @status.stub!(:source).and_return('<a href="http://echofon.com/" rel="nofollow">Echofon</a>')
    @user    = stub "user"
    @user.stub!(:status).and_return(@status)
  end

  it "should provide version command" do
    @gateway.names.should == ['version']
  end

  it "should show the source via DB" do
    @statuses.
      should_receive(:find_by_screen_name).
      with('mzp',:limit => 1).
      and_return([ entry(@user,@status) ])
    @channel.should_receive(:notify).with("Echofon <http://echofon.com/>")
    call '#twitter','version',%w(mzp)
  end

  it "should show the source of web" do
    status  = stub "status"
    status.stub!(:source).and_return(nil)
    @statuses.
      should_receive(:find_by_screen_name).
      with('mzp',:limit => 1).
      and_return([ entry(@user,status) ])
    @channel.should_receive(:notify).with("web")
    call '#twitter','version',%w(mzp)
  end

  it "should show the source via API" do
    @statuses.stub!(:find_by_screen_name).and_return(@status)
    @statuses.should_receive(:find_by_screen_name).with('mzp',:limit => 1).and_return(nil)
    @statuses.should_receive(:add).with(:status => @status, :user => @user, :source=>:version)
    @api.should_receive(:get).with('users/show',:screen_name=>'mzp').and_return(@user)

    @channel.should_receive(:notify).with("Echofon <http://echofon.com/>")

    call '#twitter','version',%w(mzp)
  end
end