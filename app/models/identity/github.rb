class Identity::Github < ApplicationRecord
  belongs_to :identity

  def events(from = nil, to = nil)
    from ||= Time.new(now.year, now.month, now.day)
    to ||= now

    client.user_events(identity.nickname).each.with_object([]) do |event, memo|
      next unless event && aggressives.include?(event.type)
      if from <= event.created_at.localtime && event.created_at.localtime <= to
        memo << extract_by(event) if extract_by(event)
      end
    end.flatten
  end

  private

  def client
    @client ||= Octokit::Client.new(
      access_token: token
    )
  end

  def aggressives
    %w(
      IssuesEvent
      IssueCommentEvent
      PullRequestEvent
      PullRequestReviewCommentEvent
      CommitCommentEvent
      PushEvent
    )
  end

  def extract_by(event)
    return nil if event.payload.action && event.payload.action != 'created'

    case event.type
    when 'IssuesEvent'
      {
        type:    :issue,
        repo:    event.repo.name,
        title:   event.payload.issue.title,
        comment: nil,
      }
    when 'IssueCommentEvent'
      {
        type:    :comment,
        repo:    event.repo.name,
        title:   event.payload.issue.title,
        comment: event.payload.comment.body,
      }
    when 'PullRequestEvent'
      {
        type:    :issue,
        repo:    event.repo.name,
        title:   event.payload.pull_request.title,
        comment: nil,
      }
    when 'PullRequestReviewCommentEvent'
      {
        type:    :comment,
        repo:    event.repo.name,
        title:   event.payload.pull_request.title,
        comment: event.payload.comment.body,
      }
    when 'CommitCommentEvent'
      {
        type:    :comment,
        repo:    event.repo.name,
        title:   event.payload.pull_request.title,
        comment: event.payload.comment.body,
      }
    when 'PushEvent'
      commits = event.payload.commits.select {|c| c.author.name == identity.nickname }
      return nil if commits.empty?

      commits.each_with_object([]) do |commit, array|
        array << {
          type:    :commit,
          repo:    event.repo.name,
          title:   nil,
          comment: commit.message,
        }
      end
    end
  end
end
