class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user # Asocia el comentario al usuario actual
    if @comment.save
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end
def edit
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id])
end
def update
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id])
  if @comment.update(comment_params)
    redirect_to article_path(@article), notice: 'Comentario actualizado con éxito.'
  else
    render 'edit'
  end
end


  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end

