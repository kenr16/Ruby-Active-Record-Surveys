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
  @survey = Survey.find(params['id'])
  @questions = @survey.questions
  erb(:survey)
end

post('/survey/:id/add_question') do
  survey = Survey.find(params['id'])
  question = params['question']
  Question.create({:content => question, :answers => nil, :survey_id => survey.id})
  redirect("/survey/#{survey.id}")
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
