#!/usr/bin/env ruby
# encoding: UTF-8

require 'thor'
require 'ruby-plsql'
require 'awesome_print'
require 'pg'

class SyncSvaPersonalPGDTbl < Thor

  desc 'fetch','fetch'
  def fetch
    connect_umt

    puts plsql.hissosexp.count

    connect_pg

    @pg.exec('select count(*) from personal_pgd') do |cursor|
      ap cursor.first
    end
  end

private
  def connect_pg
    @pg = PG.connect(
      dbname:   ENV.fetch('PG_ZUV_INSTANCE'),
      host:     ENV.fetch('PG_ZUV_HOST'),
      port:     ENV.fetch('PG_ZUV_PORT'),
      user:     ENV.fetch('PG_ZUV_USER'),
      password: ENV.fetch('PG_ZUV_PASSWORD'))

  end

  def connect_umt
    plsql.connection = OCI8.new(
      ENV.fetch('UMT_USER'),
      ENV.fetch('UMT_PASSWORD'),
      ENV.fetch('UMT_SID'))
  end
end

SyncSvaPersonalPGDTbl.start
