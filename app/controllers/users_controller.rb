class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if @user == @current_user
    else
      flash[:error] = "You cannot edit other user's information"
      redirect_to users_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:sucess] = "Created New User Successfully!"
      redirect_to users_path
    else
      flash[:error] = "Unable to Create New User"
      render :new
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == @current_user
      @user.destroy
      sign_out
      redirect_to root_path
    else
      flash[:error] = "You cannot delete other users!"
      redirect_to users_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def authenticate
      authenticate_or_request_with_http_digest do |username|
        USERS[username] || false
      end
    end
end
