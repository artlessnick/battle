class GameprocessesController < ApplicationController
  def start_game
    current_user.increment!(:allgame)
    @game = Gamescore.create(user_id: current_user.id, num_game: current_user.allgame)
    @round = Round.create(gamescore_id: @game.id, num_round: @game.count_round)
    @user_answers = RoundAnswer.create(round_id: @round.id)

    @all_category = Question.select(:category).distinct.pluck(:category)
    @category_for_change = @all_category.sample(2)
  end

  def question_for_game
    @category = params[:category_for_game]
    @game_id = params[:gid]
    @round_id = params[:rid]
    @user_answers_id = params[:aid]
    @answers = []
    @game = Gamescore.find(@game_id)
    @round = Round.find(@round_id)

    if @game.selected_questions == nil
      @question = Question.where(category: @category).sample
      @game.update(selected_questions: @question.id)

      @results = Result.create(category: @category, user_id: current_user.id)
    else 
      @all_selected_questions = @game.selected_questions
      @selected_questions = @all_selected_questions.split(", ")
      @question = Question.where(category: @category).where.not(id: @selected_questions).sample
      @game.update!(selected_questions: @all_selected_questions + ", " + @question.id.to_s)

      @results = Result.find(params[:results])
      if @results.category == nil
        @results.update(category: @category)
      end
    end
      @answers.push(@question.answer1, @question.answer2, @question.answer3, @question.answer4)
      @round.increment!(:count_questions)
  end

  def submit_answer
    @game = Gamescore.find(params[:gid])
    @round = Round.find(params[:rid])
    @user_answers = RoundAnswer.find(params[:aid])
    @question = Question.find(params[:changed_question])
    @player_answer = params[:answer]
    @results = Result.find(params[:results])

    @results.increment!(:quentity_questions)

    @num_question = :"question#{@round.count_questions}_id"
    @num_answer = :"answer#{@round.count_questions}"
    
    @user_answers.update(
            @num_question => @question.id, 
            @num_answer => @player_answer
    )

    if @player_answer == @question.trueanswer
      @round.increment!(:roundscore)
      @results.increment!(:correct_answers)
    end

    while @round.count_questions < 3
      redirect_to question_path(:category_for_game => @question.category, :gid => @game.id, :rid => @round.id, :aid => @user_answers.id, :results => @results.id) and return
    end

    @game.increment!(:count_round)
    @game.increment!(:score_game, @round.roundscore)

    if @round.num_round < 3

      if @game.selected_categorys == nil
        @game.update(selected_categorys: @question.category)
        @array = @question.category
      else 
        @selected_categorys = @game.selected_categorys
        @game.update(selected_categorys: @selected_categorys + ", " + @question.category)
        @array = @game.selected_categorys.split(", ")
      end
      @next_categorys = Question.where.not(category: @array).distinct.pluck(:category).sample(2)
      @new_round = Round.create!(gamescore_id: @game.id, num_round: @game.count_round)
      @new_user_answers = RoundAnswer.create!(round_id: @new_round.id)
      @new_results = Result.create(user_id: current_user.id)

      render "category"
    else
      for_rating
      redirect_to current_user
    end
  end

  private
  def for_rating
    @result = Result.where(user_id: current_user.id)
    @sum_quest = @result.sum('quentity_questions')
    @sum_answers = @result.sum('correct_answers')
    @percent = @sum_answers * 100 / @sum_quest
    User.find(current_user.id).update!(percent_correct_answers: @percent)
  end
end
