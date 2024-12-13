class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_available_roles, only: [ :new, :create, :update, :edit ]
  before_action :restrict_employee_access
  before_action :restrict_manager_access, only: [ :update, :edit, :destroy ]
  before_action :set_render_cart
  skip_before_action :initialize_cart

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.password = @user.username
    @user.password_confirmation = @user.username

    if creating_admin_user? && Current.user.role.name == "Gerente"
        redirect_to users_path, alert: I18n.t("users.alerts.create_admin")
      return
    end


    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: I18n.t("users.create.success") }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if creating_admin_user? && Current.user.role.name == "Gerente"
      redirect_to users_path, alert: I18n.t("users.alerts.create_admin")
      return
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: I18n.t("users.edit.success") }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    random_password = SecureRandom.hex(16)

    if @user.update(active: false, password: random_password, password_confirmation: random_password)
      respond_to do |format|
        format.html { redirect_to users_path, status: :see_other, notice: I18n.t("users.destroy.success") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to users_path, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_render_cart
      @render_cart = false
    end
    def restrict_employee_access
      # Restrinjo el acceso a los empleados: si quiere destruir, lo prohibo. Otra acción, si es sobre el mismo, la permito
      if Current.user.role.name == "Empleado"
        if action_name == "destroy"
          redirect_to dashboard_index_path, alert: I18n.t("users.alerts.restrict_destroy")
        elsif Current.user != @user
          redirect_to dashboard_index_path, alert: I18n.t("users.alerts.restrict")
        end
      end
    end

    def restrict_manager_access
      if Current.user.role.name == "Gerente" && @user.role.name == "Administrador"
        redirect_to users_path, alert: I18n.t("users.alerts.restrict_manager")
      end
    end

    def creating_admin_user?
      params[:user][:role_id].present? && Role.find(params[:user][:role_id]).name == "Administrador"
    end

    def set_available_roles
      if Current.user.role.name == "Gerente"
        @available_roles = Role.where.not(name: "Administrador")  # Excluir Administrador si es Gerente
      else
        @available_roles = Role.all
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :username, :email_address, :phone, :password, :entry_date, :active, :role_id ])
    end
end
