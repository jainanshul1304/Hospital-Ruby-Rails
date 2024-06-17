class PatientsController < ApplicationController
  skip_before_action :require_user, only: [:index, :show,:clean]
  
    def index
      @per_page = 12
      @current_page = [params.fetch(:page, 1).to_i, 1].max
      @total_pages = (Patient.count.to_f / @per_page.to_f).ceil
      @patients = Patient.search(params[:term], @per_page, @current_page)
    end
    def graph
      @patient_counts = Patient.count_by_day
         render 'graph'
    end
    def show
      @patient = Patient.find(params[:id])
    end
  
    def new
      @patient = Patient.new
    end
  
    def edit
      redirect_not_same_user
      @patient = Patient.find(params[:id])
    end
  
    def create
      @current_user = current_user
      
      @patient = @current_user.patients.new(patient_params)
  
      if @patient.save
        redirect_to @patient
      else
        render 'new'
      end
    end
  
    def update
      redirect_not_same_user
      @patient = Patient.find(params[:id])
      if @patient.update(patient_params)
        redirect_to @patient
      else
        render 'edit'
      end
    end
  
    def destroy
      redirect_not_same_user
      @patient = Patient.find(params[:id])
      @patient.destroy
  
      redirect_to patients_path
    end
  
    def clean
      current_user.patients.destroy_all
      redirect_to patients_path, notice: "All patients cleaned successfully."
    end
    def dashboard
      @per_page = 12
      @current_page = [params.fetch(:page, 1).to_i, 1].max
      @total_pages = (Patient.where(user_id: current_user.id).count.to_f / @per_page.to_f).ceil
      @patients = Patient.offset((@current_page - 1) * @per_page).limit(@per_page).where(user_id: current_user.id)
      render :template => "patients/index.html.erb"
    end
  
    private
  
    def patient_params
      params.require(:patient).permit(:patient_name, :category, :description, :contact_email)
    end
    def authorize_doctor
      unless current_user&.role == 'doctor'
        flash[:alert] = "Only doctors can access this page."
        redirect_to root_path
      end
    end
    def redirect_not_same_user
      @patient = Patient.find(params[:id])
      redirect_to patients_path unless current_user.id == @patient.user.id
    end
  end
  