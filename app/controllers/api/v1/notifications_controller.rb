class Api::V1::NotificationsController < Api::V1::BaseController
  def index
    return render json: nil if current_user.notifications.blank?

    render json: current_user.notifications.order(created_at: :desc).as_json(only: [:id, :created_at, :title, :read])
  end

  def show
    notification = Notification.find(params[:id])

    return render json: { error: 'Permission denied.' }, status: :forbidden unless notification.user == current_user
   
		mark_as_read(notification) if notification.read == false
    render json: notification.description
	end

	def destroy
    notification = Notification.find(params[:id])

    return render json: { error: 'Permission denied.' }, status: :forbidden unless notification.user == current_user

    Notification.find(params[:id]).destroy
    render json: 'Notification was successfully deleted!'
	end

  private

  def mark_as_read(notification)
    notification.update(read: true, read_at: DateTime.now)
	end
end
