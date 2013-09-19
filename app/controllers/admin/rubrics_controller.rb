class Admin::RubricsController < Admin::BaseController
  before_action :set_rubric, only: [:show, :edit, :update, :destroy]
  before_action :set_rubrics_for_select, only: [:new, :edit]

  def index
    @rubrics = Rubric.all
  end

  def show
  end

  def new
    @rubric = Rubric.new
  end

  def edit
  end

  def create
    @rubric = Rubric.new(rubric_params)

    if @rubric.save
      redirect_to admin_rubric_path(@rubric), notice: 'Rubric was successfully created.'
    else
      set_rubrics_for_select
      render action: 'new'
    end
  end

  def update
    if @rubric.update(rubric_params)
      redirect_to admin_rubric_path(@rubric), notice: 'Rubric was successfully updated.'
    else
      set_rubrics_for_select
      render action: 'edit'
    end
  end

  def destroy
    @rubric.destroy
    redirect_to admin_rubrics_url, notice: 'Rubric was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rubric
    @rubric = Rubric.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def rubric_params
    params.require(:rubric).permit(:title, :language, :translation_id)
  end

  #Private. Set @rubrics_for_translation for create\update form (translated rubric)
  def set_rubrics_for_select
    @rubrics_for_translation = Rubric.where('id != ?', @rubric.try(:id) || 0).select(:title, :id).to_a
  end
end
