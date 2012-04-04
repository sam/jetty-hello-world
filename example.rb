#!/usr/bin/env jruby

# Setup:
# curl http://download.eclipse.org/jetty/stable-8/dist/jetty-distribution-8.1.2.v20120308.tar.gz | tar -xz -

require "java"

jars = File.join(File.dirname(__FILE__), "jetty-distribution-8.1.2.v20120308", "lib", "*.jar")
Dir[jars].each { |jar| require jar }

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.servlet.ServletException

import org.eclipse.jetty.server.Server
import org.eclipse.jetty.server.handler.AbstractHandler

class HelloWorld < AbstractHandler
  
  def handle(target, base_request, request, response)
    response.content_type = "text/html;charset=utf-8"
    response.status = HttpServletResponse::SC_OK
    base_request.handled = true
    response.writer.println "<h1>Hello World!</h1>"
  end
end

server = Server.new 9292
server.handler = HelloWorld.new

server.start
server.join