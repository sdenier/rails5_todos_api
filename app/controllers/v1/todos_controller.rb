class V1::TodosController < ApplicationController

  before_action :find_todo, only: [:show, :update, :destroy]

  def index
    @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
    json_response(@todos)
  end

  def show
    json_response(@todo)
  end

  def create
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  def update
    @todo.update(todo_params)
    json_response(@todo)
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def find_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.permit(:title)
  end

end
