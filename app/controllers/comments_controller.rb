class CommentsController < ApplicationController
	def show
		@article = Article.find(params[:id])
		@comment = @article.comments.find(params[:id])
	end

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
			flash[:success] = "Comment was successfully created"
		redirect_to article_path(@article)
	end
	def destroy
		@article = Article.find(params[:article_id])
		@comment = Comment.all.where(:article => params[:id]).first
		@comment.destroy
			flash[:danger] = "Comment was successfully destroyed"
		redirect_to article_path
	end
	
	private
		def comment_params
			params.require(:comment).permit(:commenter, :body, :user_id, :article_id)
		end
end
