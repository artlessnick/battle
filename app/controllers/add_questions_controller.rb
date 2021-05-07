class AddQuestionsController < ApplicationController

  def new_questions
    @categorys_array = ["В мире кино", "Флора и фауна", "В здоровом теле", "Музыка", "Игры всех сортов", "Верю не верю", 
      "XXI век", "Гранит науки", "Изба читальня", "Сериалы", "Мультики и комиксы", "История сквозь века", "Технический прогресс", 
      "Знаменитости и СМИ", "Искусство и культура", "Власть и деньги", "В мире спорта", "Вокруг света", "Хлеб да соль"]
    @categorys = @categorys_array.map{ |u| u}
    @users = User.all
  end

  def create_questions
    @question = Question.new(category: params[:category],
                                 question: params[:addquest][:question],
                                 trueanswer: params[:addquest][:trueanswer],
                                 answer1: params[:addquest][:trueanswer],
                                 answer2: params[:addquest][:answer2],
                                 answer3: params[:addquest][:answer3],
                                 answer4: params[:addquest][:answer4],)
    if @question.save
      flash[:success] = "Question save"
      redirect_to current_user
    else   
      render "new_questions"
    end
  end

end
