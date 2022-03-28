# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TrainOperator.create(
  name: "Train Operator",
  email: "train-operator@yopmail.com",
  password: "train-operator")

PostMaster.create(
  name: "Post Master",
  email: "post-master@yopmail.com",
  password: "post-master")

ParcelOwner.create(
  name: "Parcel Owner",
  email: "parcel-owner@yopmail.com",
  password: "parcel-owner")
