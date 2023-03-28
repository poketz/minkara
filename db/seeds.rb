# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [
    {name: 'ひろし', password: 'password', email: 'e@mail', gender: 0, prefecture: 15, birthday: '1995-10-10'},
    {name: 'みほ', password: 'password', email: 'e@mail2', gender: 1, prefecture: 11, birthday: '1988-06-23'},
    {name: 'りさ', password: 'password', email: 'e@mail3', gender: 1, prefecture: 13, birthday: '1991-12-02'},
    {name: 'たけひと', password: 'password', email: 'e@mail4', gender: 0, prefecture: 15, birthday: '1956-05-19'},
    {name: 'よしひろ', password: 'password', email: 'e@mail5', gender: 0, prefecture: 13, birthday: '1985-08-05'},
  ]
)