require 'jira-ruby'
require 'pry'


host = "https://qwinix.atlassian.net/secure/RapidBoard.jspa?rapidView=338&projectKey=RECX&view=detail&selectedIssue=RECX-25"
username = "upatel@qwinix.io"
password = "Qwinix123"
 project = "Recx"
status = "IN PROGRESS"

options = {
            :username => username,
            :password => password,
            :context_path => '',
            :site     => host,
            :auth_type => :basic
          }

SCHEDULER.every '1h', :first_in => 0 do |job|
  client = JIRA::Client.new(options)
  num = 0;
  client.Issue.jql("PROJECT = \"#{project}\" AND STATUS = \"#{status}\"").each do |issue|
      num+=1
  end
  send_event('jira', { current: num})
end