class MasterController < ApplicationController
  def clock
  end

  def names
  end

  def create_person
    Pusher.trigger('meetup', 'person_created', {name: params[:name], color: params[:color]})
  end

  def remove_person
    Pusher.trigger('meetup', 'person_removed', {name: params[:name]})
    render :nothing => true
  end
end
