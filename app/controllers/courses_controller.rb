class CoursesController < ApplicationController
  before_action :authenticate_manager
  before_action :find_categories, only: [:index, :new, :create, :edit, :update]
  before_action :find_course, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
    @courses = if params[:category_id].present?
                 Course.includes(:category).where(category_id: params[:category_id])
               else
                Course.includes(:category).all
               end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: "Create success"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: "Update success"
    else
      render :edit
    end
  end

  def destroy
    if @course.destroy
      redirect_to courses_path, notice: "Delete success"
    else
      redircet_to courses_path, notice: "Delete unsuccess"
    end
  end

  private

  def course_params
    params.require(:course).permit(:subject, :price, :currency, :launch, :url, :description, :expire_day, :category_id)
  end

  def find_categories
    @categories = Category.all
  end

  def find_course
    @course = Course.find(params[:id])
  end
end
