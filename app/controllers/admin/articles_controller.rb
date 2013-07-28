class Admin::ArticlesController < Admin::BaseController
  include TinyMCE::Rails::Helper
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :prepare_article_form, only: [:new, :edit]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to admin_article_path(@article), notice: 'Article was successfully created.'
    else
      prepare_article_form
      render action: 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to admin_article_path(@article), notice: 'Article was successfully updated.'
    else
      prepare_article_form
      render action: 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_url, notice: 'Article was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.require(:article).permit(:title, :body, :translation_id, :meta_description, :published, :language,{:rubric_ids => []})
  end

  #Private. Set all variables for form. 
  #         Set @articles_for_translation for create\update form (translated article)
  #         Set @article_rubrics for create\update form. HABTM with rubrics
  #
  def prepare_article_form
    @articles_for_translation = Article.where('id != ?', @article.try(:id) || 0).select(:title, :id).to_a
    @article_rubrics = Rubric.all
  end

end
