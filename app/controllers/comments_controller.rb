class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
    
    def create
        @post = Post.find(params[:post_id])
        comment = @post.comments.new(comment_params)
        comment.user = current_user
 
        if comment.save
            flash[:notice] = "Comment saved successfully."
            redirect_to [@post.topic, @post]
        else
            flash[:alert] = "Comment failed to save."
            redirect_to [@post.topic, @post]
        end
        
        # @topic = Topic.find(params[:topic_id])
        # commentT = @topic.comments.new(comment_params)
        # commentT.user = current_user
        
        # if commentT.save
        #     flash[:notice] = "Comment saved successfully."
        #     redirect_to [@topic, @topic]
        # else
        #     flash[:alert] = "Comment failed to save."
        #     render :new
        # end
    end
    
    # def createT
    #     @comment = Comment.new
    #     @topic = Topic.find(params[:topic_id])
    #     @comment.topic = @topic
        
    #     if @comment.save
    #         flash[:notice] = "Comment saved successfully."
    #         redirect_to [@topic, @comment]
    #     else
    #         flash[:alert] = "Comment failed to save."
    #         render :new
    #     end
    # end
    
    def destroy
        @post = Post.find(params[:post_id])
        comment = @post.comments.find(params[:id])
 
        if comment.destroy
            flash[:notice] = "Comment was deleted successfully."
            redirect_to [@post.topic, @post]
        else
            flash[:alert] = "Comment couldn't be deleted. Try again."
            redirect_to [@post.topic, @post]
        end
        
        # @topic = Topic.find(params[:topic_id])
        # commentT = @topic.comments.find(params[:id])
        
        # if commentT.destroy
        #     flash[:notice] = "Comment was deleted successfully"
        #     redirect_to [:topic][:index]
        # else
        #     flash[:alert] = "Comment couldn't be deleted. Try again."
        #     redirected_to [topics_path]
        # end
    end
    
    # def destroyT
    #     @comment = Comment.find(params[:id])
        
    #     if @comment.destroy
    #         flash[:notice] = "Comment was deleted successfully"
    #         redirect_to @comment.topic
    #     else
    #         flash[:alert] = "Comment couldn't be deleted. Try again."
    #         render: show
    #     end
    # end
 
    private

    def comment_params
        params.require(:comment).permit(:body)
    end
    
    def authorize_user
        comment = Comment.find(params[:id])
        unless current_user == comment.user || current_user.admin?
            flash[:alert] = "You do not have permission to delete a comment."
            redirect_to [comment.post.topic, comment.post]
        end
    end
end
