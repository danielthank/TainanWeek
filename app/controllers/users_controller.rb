class UsersController < ApplicationController
  def determine
    id = params[:student_id]
    @user = User.where(student_id: id)
    @debug = @user.exists?
    if @user.exists?
      @user = @user.first
      @method = :patch
    else
      @user = User.new(student_id: id)
      @method = :post
    end
  end
  def create
    @user = params[:user]
    flash[:error] = ''
    if @user[:studentId] =~ /[a-zA-Z]\d{8}/
      @user[:studentId][0] = @user[:studentId][0].upcase
    else
      flash[:error] += create_alert('學號格式不正確')
    end
    unless @user[:mobile] =~ /09\d{8}/
      flash[:error] += create_alert('手機格式不正確')
    end
    unless @user[:password] == @user[:confirm]
      flash[:error] += create_alert('確認密碼不相符')
    end
    @user[:test] = flash[:error]
    if flash[:error].blank?
      render :test
    else
      redirect_to user_new_path
    end
  end
  def update
    tmp = user_params
    user = User.where(student_id: tmp[:student_id]).first
    user.update(tmp)
    redirect_to user_path
  end
  private
  def create_alert str
    return '<div class="alert alert-danger">' + str + '</div>'
  end
  def user_params
    params.require(:user).permit(:name, :student_id, :department, :mobile)
  end
end
