require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/surveys')
require('./lib/questions')
require('pg')
require('pry')

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

# ADD SURVEY
post('/add_survey') do
  name = params['survey_name']
  Survey.create({:name => name})
  redirect('/')
end

# SURVEY PAGE
get('/survey/:id') do
  @counter = 0
  @survey = Survey.find(params['id'])
  @questions = @survey.questions
  @question = @questions[@counter]
  erb(:survey)
end

post('/survey/:id/add_question') do
  survey = Survey.find(params['id'])
  question = params['question']
  Question.create({:content => question, :answers => nil, :survey_id => survey.id})
  redirect("/survey/#{survey.id}")
end

post('/survey/:id') do
  @counter = params['question_id'].to_i
  @counter += 1
  @survey = Survey.find(params['id'])
  @questions = @survey.questions
  answers = []
  if @counter == (@questions.length)
    answers.each do |key, value|
      key.update({:answer => value})
      binding.pry
    end
    redirect("survey/#{@survey.id}/result")
  else
    @question = @questions[@counter]
    answer = params["questions_answer"]
    answers.push({@question => answer})
  end

  erb(:survey)
end

#results
get('/survey/:id/result') do
  @survey = Survey.find(params['id'])
  @questions = @survey.questions
  erb(:result)
end

post('/survey/:id/responses') do
  survey = Survey.find(params['id'])
  questions = survey.questions
  questions.each do |question|
    answer = params["#{question.id}"]
    question.update({:answers => answer})
  end
  redirect("/survey/#{survey.id}/result")
end

delete('/survey/:id/delete') do
  survey = Survey.find(params['id'])
  survey.destroy
  survey.questions.each do |question|
    question.destroy
  end
  redirect('/')
end

get('/survey/:id/update') do
  @survey = Survey.find(params['id'])
  @questions = @survey.questions
  erb(:survey_update)
end

patch('/survey/:id/modify') do
  survey = Survey.find(params['id'])
  new_name = params['survey_name']
  survey.update({:name => new_name})
  questions = survey.questions
  questions.each do |question|
    new_question = params["#{question.id}"]
    question.update({:content => new_question})
  end
  redirect("/survey/#{survey.id}")
end
