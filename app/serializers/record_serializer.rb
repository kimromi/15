class RecordSerializer < ActiveModel::Serializer
  attributes :id, :task, :date, :time

  def task
    object.task
  end

  def date
    object.at.to_date
  end

  def time
    object.at.strftime('%k:%M').strip
  end
end
