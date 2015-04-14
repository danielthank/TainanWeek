class UsersController < ApplicationController
  def determine
    @user = params[:user]
    if @user[:student_id] =~ /^[a-zA-Z]\d{8}$/
      @user[:student_id][0] = @user[:student_id][0].upcase
    else
      flash[:error] = create_alert('學號格式不正確')
      redirect_to user_login_path
      return
    end


    require 'digest/md5'
    userNow = User.where(student_id: @user[:student_id], password: Digest::MD5.hexdigest(@user[:password]))
    if userNow.blank?
      flash[:error] = create_alert('學號密碼錯誤')
      redirect_to user_login_path
    else
      session[:user] = {id: userNow.first.id, name: userNow.first.name}
      redirect_to root_path
    end
  end
  def create
    @user = params[:user]
    flash[:error] = ''

    if User.exists?(student_id: @user[:student_id])
      flash[:error] += create_alert('學號已經註冊過')
      redirect_to user_new_path
      return
    end

    if @user[:student_id] =~ /^[a-zA-Z]\d{8}$/
      @user[:student_id][0] = @user[:student_id][0].upcase
    else
      flash[:error] += create_alert('學號格式不正確')
    end

    if @user[:name].blank?
      flash[:error] += create_alert('未填姓名')
    end
    
    if @user[:department].blank?
      flash[:error] += create_alert('未填系級')
    end

    unless @user[:mobile] =~ /^09\d{8}*/
      flash[:error] += create_alert('手機格式不正確')
    end

    if @user[:password].blank? || @user[:password].blank?
      flash[:error] += create_alert('密碼未填')
    elsif
      @user[:password] != @user[:confirm]
      flash[:error] += create_alert('確認密碼不相符')
    end

    if flash[:error].blank?
      require 'digest/md5'
      User.create(name: @user[:name], student_id: @user[:student_id], department: @user[:department], mobile: @user[:mobile], password: Digest::MD5.hexdigest(@user[:password]))
      render :success
    else
      redirect_to user_new_path
    end
  end
  def logout
    session[:user] = nil
    redirect_to root_path
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
