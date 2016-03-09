# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    User.create(name: 'Michelle', nickname: 'Michelle1', email: 'msisti@brandeis.edu', password: '12345678', admin: 'true')
    User.create(name: 'Nishan', nickname: 'Nishan1', email: 'acharyan@brandeis.edu', password: '12345678', admin: 'true')
    User.create(name: 'Ken', nickname: 'Ken1',email: 'kharsch@brandeis.edu', password: '12345678', admin: 'true')

    User.create(name: 'JoeC', nickname: 'JoeC1', email: 'jcarter@brandeis.edu', password: '12345678')
    User.create(name: 'Kruk', nickname: 'Kruk1', email: 'jkruk@brandeis.edu', password: '12345678')
    User.create(name: 'Vida', nickname: 'Vida1', email: 'vblue@brandeis.edu', password: '12345678')
    User.create(name: 'Babe', nickname: 'Babe1', email: 'gruth@brandeis.edu', password: '12345678')
    User.create(name: 'Grover', nickname: 'Grover1', email: 'mhargrove@brandeis.edu', password: '12345678')
    User.create(name: 'Say Hey', nickname: 'Say Hey1', email: 'wmayes@brandeis.edu', password: '12345678')

   Assignment.create(title: 'Assignment 1', description: 'Assignment 1 description', draft_deadline: '2016-01-30 05:00:00', final_deadline: '2016-01-31 05:00:00')
   Assignment.create(title: 'Assignment 2', description: 'Assignment 2 description', draft_deadline: '2016-02-15 05:00:00', final_deadline: '2016-02-17 05:00:00')

   Position.create(title: 'For', assignment_id: 1)
   Position.create(title: 'Against', assignment_id: 1)
   Position.create(title: 'Neutral', assignment_id: 1)

   Post.create(headline: 'Headline3', draft1: 'Draft 1-3', draft2: 'Draft2-3', user_id: 3, assignment_id: 1, submitted: true)
   Post.create(headline: 'Headline4', draft1: 'Draft 1-4', draft2: 'Draft2-4', user_id: 4, assignment_id: 1, submitted: true)
   Post.create(headline: 'Headline5', draft1: 'Draft 1-5', draft2: 'Draft2-5', user_id: 5, assignment_id: 1, submitted: true)
   Post.create(headline: 'Headline6', draft1: 'Draft 1-6', draft2: 'Draft2-6', user_id: 6, assignment_id: 1, submitted: true)
   Post.create(headline: 'Headline7', draft1: 'Draft 1-7', draft2: 'Draft2-7', user_id: 7, assignment_id: 1, submitted: true)
   Post.create(headline: 'Headline8', draft1: 'Draft 1-8', draft2: 'Draft2-8', user_id: 8, assignment_id: 1, submitted: true)

   Post.create(headline: 'Headline3', draft1: 'Draft 1-3', user_id: 3, assignment_id: 2, submitted: true)
   Post.create(headline: 'Headline4', draft1: 'Draft 1-4', user_id: 4, assignment_id: 2, submitted: true)
   Post.create(headline: 'Headline5', draft1: 'Draft 1-5', user_id: 5, assignment_id: 2, submitted: true)
   Post.create(headline: 'Headline6', draft1: 'Draft 1-6', user_id: 6, assignment_id: 2, submitted: true)
   Post.create(headline: 'Headline7', draft1: 'Draft 1-7', user_id: 7, assignment_id: 2, submitted: true)
   Post.create(headline: 'Headline8', draft1: 'Draft 1-8', user_id: 8, assignment_id: 2, submitted: true)

   Evaluation.create(post_id: 1, user_id: 4)
   Evaluation.create(post_id: 3, user_id: 4)
   Evaluation.create(post_id: 4, user_id: 4)
   Evaluation.create(post_id: 5, user_id: 4)

   Evaluation.create(post_id: 2, user_id: 3)
   Evaluation.create(post_id: 3, user_id: 3)
   Evaluation.create(post_id: 4, user_id: 3)
   Evaluation.create(post_id: 5, user_id: 3)

   Evaluation.create(post_id: 2, user_id: 5)
   Evaluation.create(post_id: 4, user_id: 5)
   Evaluation.create(post_id: 5, user_id: 5)
   Evaluation.create(post_id: 6, user_id: 5)

   Evaluation.create(post_id: 1, user_id: 6)
   Evaluation.create(post_id: 2, user_id: 6)
   Evaluation.create(post_id: 4, user_id: 6)
   Evaluation.create(post_id: 6, user_id: 6)

   Evaluation.create(post_id: 1, user_id: 7)
   Evaluation.create(post_id: 3, user_id: 7)
   Evaluation.create(post_id: 2, user_id: 7)
   Evaluation.create(post_id: 5, user_id: 7)

   Evaluation.create(post_id: 1, user_id: 8)
   Evaluation.create(post_id: 3, user_id: 8)
   Evaluation.create(post_id: 4, user_id: 8)
   Evaluation.create(post_id: 6, user_id: 8)
