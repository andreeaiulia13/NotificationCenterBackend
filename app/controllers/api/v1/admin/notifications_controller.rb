class Api::V1::Admin::NotificationsController < Api::V1::BaseController
  include Api::V1::Admin::NotificationsControllerDoc

  before_action :check_authority!

  def create
    return render json: { error: 'Title is missing' }, status: :bad_request if notification_params[:title].nil?
    return render json: { error: 'Description is missing' }, status: :bad_request if notification_params[:description].nil?
    return render json: { error: 'Client is missing' }, status: :bad_request if params[:emails].nil?
    
    notifications = []

    params[:emails].split(', ').each do |email|
      user = User.find_by(email: email)	
      return render json: { error: "There is no client with this email: #{email}. Please try again."}, status: :bad_request if user.nil?

      notifications << Notification.new(notification_params.merge(user_id: user.id))
    end

    notifications.each { |notification| notification.save! }

    render json: { message: 'Notifications were generated successfully!' }
  end


  def read_notifications 
    render json: Notification.where(read: true).order(read_at: :desc)
  end

  def unread_notifications 
    render json: Notification.where(read: false).order(created_at: :desc)
  end

  private

    def notification_params
      params.require(:notification).permit(:title, :description, :read, :read_at)
    end

    def check_authority!
      render json: { error: 'Permission denied.' }, status: :forbidden if current_user.admin == false
    end
end
