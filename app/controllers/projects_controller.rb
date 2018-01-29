class ProjectsController < ApplicationController

  def show
  end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(allowed_params)
    if @project.save
      flash[:notice] = 'Successfully created project.'
      redirect_to projects_path
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(allowed_params)
      redirect_to @project, notice: 'Successfully updated project'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = 'Successfully destoryed project.'
      redirect_to projects_path
    else
      render :show
    end
  end

  private

  def allowed_params
    params.require(:project).permit(:name, tasks_attributes: [:id, :name, :_destroy])
  end
end
