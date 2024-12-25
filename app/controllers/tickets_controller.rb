class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update update_state destroy ]

  def index
    @tickets = Ticket.all.group_by(&:state)
    @new_ticket = Ticket.new
  end

  def show
  end

  def new
    @ticket = Ticket.new(state: params[:state])
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      flash.notice = "Ticket was successfully created"
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @ticket }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Ticket was successfully updated", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_state
    @ticket.update(state: params.require(:state))
    redirect_back_or_to root_path
  end

  def destroy
    @ticket.destroy!
    redirect_to root_path, notice: "Ticket was successfully destroyed", status: :see_other
  end

  private

  def set_ticket
    @ticket = Ticket.find(params.expect(:id))
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :state)
  end
end
