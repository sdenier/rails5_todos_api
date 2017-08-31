class ItemsController < ApplicationController

  before_action :find_todo
  before_action :find_item, only: [:show, :update, :destroy]

  def index
    json_response(@todo.items)
  end

  def show
    json_response(@item)
  end

  def create
    @item = @todo.items.create!(item_params)
    json_response(@item, :created)
  end

  def update
    @item.update(item_params)
    json_response(@item)
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def find_todo
    @todo = Todo.find(params[:todo_id])
  end

  def find_item
    @item = @todo.items.find_by!(id: params[:id]) if @todo
  end

  def item_params
    params.permit(:name, :done)
  end

end
