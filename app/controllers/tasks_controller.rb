class TasksController < ApplicationController
    
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = "Taskが正常に追加されました"
            redirect_to @task
        else
            flash.now[:danger] = "Taskが追加されませんでした"
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "Taskは正常に更新されました"
            # TasksControllerのshowアクションにとぶ
            # redirect_to @task
            redirect_to tasks_path
        else
            flash.now[:danger] = "Taskは更新されませんでした"
            render :edit
        end
        
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "Taskは正常に削除されました"
        redirect_to tasks_url
    end
    
    private
    # 今はよくわからないけど、今後きちんと理解しておく
    # TasksController内部から呼び出しているメソッドは、Privateメソッドであるべき。
    # ということまではわかった。
    def task_params
        params.require(:task).permit(:content)
    end
end
