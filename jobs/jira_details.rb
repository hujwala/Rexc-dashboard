require 'jira-ruby'
require 'pry'
SCHEDULER.every '1h', :first_in => 0 do |job|
  client = JIRA::Client.new({
    :username => "upatel@qwinix.io",
    :password => "Qwinix123",
    :site => "https://qwinix.atlassian.net/secure/RapidBoard.jspa?rapidView=338&projectKey=RECX&view=detail&selectedIssue=RECX-25",
    :auth_type => :basic,
    :context_path => ""
  })
  closed_points = client.Issue.jql("sprint in openSprints() and status = \"Done\"").map{ |issue| issue.fields['customfield_10004'].to_f }.sum

  send_event('jira_details', { title: "Jira Story Point Details", value: closed_points })
end