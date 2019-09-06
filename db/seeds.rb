# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Location.destroy_all
User.destroy_all
Flip.destroy_all
Like.destroy_all

# use create! to fail loudly (vs ::create, which fails silently)
ldn = Location.create!(name: 'London, England')
pa = Location.create!(name: 'Pennsylvania, USA')
va = Location.create!(name: 'Virginia, USA')
ma = Location.create!(name: 'Massachusetts, USA')
ca = Location.create!(name: 'California, USA')
tn = Location.create!(name: 'Tennessee, USA')
cdmx = Location.create!(name: 'Mexico City, Mexico')

# when seeding values for foreign keys, don't hard code, instead reference variable's id
  # hard coding gives us trouble when we re-seed
  # when dynamically setting foreign keys' values, order of seeding matters
lovelace = User.create!(username: "ada_lovelace", location_id: ldn.id, password: "starwars")
hopper = User.create!(username: "grace_hopper", location_id: pa.id, password: "password123")
vaughan = User.create!(username: "dorothy_vaughan", location_id: va.id, password: "hotdog")
turing = User.create!(username: "alan_turing", location_id: ldn.id, password: "hotdoghotdog")
booth = User.create!(username: "kathleen_booth", location_id: ldn.id, password: "boothit")
landin = User.create!(username: "peter_landin", location_id: ldn.id, password: "starwars")
hamilton = User.create!(username: "margaret_hamilton", location_id: ma.id, password: "password123")
stallman = User.create!(username: "richard_stallman", location_id: ma.id, password: "stallmanalert")
horton = User.create!(username: "mary_ann_horton", location_id: ca.id, password: "akathehorton")
dean = User.create!(username: "mark_dean", location_id: tn.id, password: "markison")
lam = User.create!(username: "monica_lam", location_id: ca.id, password: "ontlam")
de_icaza = User.create!(username: "miguel_de_icaza", location_id: cdmx.id, password: "whatwhat")

f0 = Flip.create!(
  body: "who is screaming \"log off\" at my house. show yourself, coward. i will never log off",
  author_id: lovelace.id
)

f1 = Flip.create!(
  body: "hear this trolls: ive been secretly respecting the flag in the privacy of my garage for 12 hrs a day , maxing out its power to insane levels",
  author_id: hopper.id
)
f2 = Flip.create!(
  body: "every morning I ask the dog \“the usual?\” before pouring her food into her bowl & neither of us thinks it’s funny but that’s showbiz baby",
  author_id: vaughan.id
)
f3 = Flip.create!(
  body: "How dare you drive the speed limit when I’m late to something due to my own poor time management skills",
  author_id: turing.id
)
f4 = Flip.create!(
  body: "it is with a heavy heart that i must announce that the celebs are at it again",
  author_id: booth.id
)
f5 = Flip.create!(
  body: "Food $200\nData $150\nRent $800\nCandles $3,600\nUtility $150\nsomeone who is good at the economy please help me budget this. my family is dying",
  author_id: landin.id
)
f6 = Flip.create!(
  body: "passed a dog wearing a vest that said \“careful! i’m still learning how to be around people\” and experienced a borderline-spiritual \“same\”",
  author_id: hamilton.id
)
f7 = Flip.create!(
  body: "hi, grandma? can u come pick me up from my rap battle? it's over. no, i lost. he saw u drop me off & did a pretty devastating rhyme about it",
  author_id: stallman.id
)
f8 = Flip.create!(
  body: "is there anything more capitalist than a peanut with a top hat, cane, and monocle selling you other peanuts to eat",
  author_id: horton.id
)
f9 = Flip.create!(
  body: "[burglar gently waking me] you live like this?",
  author_id: dean.id
)
f10 = Flip.create!(
  body: "How Can Mirrors Be Real If Our Eyes Aren't Real",
  author_id: lam.id
)

f11 = Flip.create!(
  body: "awfully bold of you to fly the Good Year blimp on a year that has been extremely bad thus far",
  author_id: de_icaza.id
)

f12 = Flip.create!(
  body: "making flips, doo doo doo doo doo doo",
  author_id: lovelace.id
)

f13 = Flip.create!(
  body: "did you know that a killer whale is a dolphin",
  author_id: lovelace.id
)

f14 = Flip.create!(
  body: "flipfloopfleep",
  author_id: lovelace.id
)

l0 = Like.create!(flip_id: f0.id, user_id: hopper.id)
l1 = Like.create!(flip_id: f0.id, user_id: vaughan.id)
l2 = Like.create!(flip_id: f0.id, user_id: turing.id)
l3 = Like.create!(flip_id: f0.id, user_id: stallman.id)
l4 = Like.create!(flip_id: f0.id, user_id: horton.id)
l5 = Like.create!(flip_id: f0.id, user_id: dean.id)
l6 = Like.create!(flip_id: f0.id, user_id: lam.id)

l7 = Like.create!(flip_id: f2.id, user_id: hamilton.id)
l8 = Like.create!(flip_id: f2.id, user_id: de_icaza.id)

l9 = Like.create!(flip_id: f3.id, user_id: booth.id)
l10 = Like.create!(flip_id: f3.id, user_id: horton.id)
l11 = Like.create!(flip_id: f3.id, user_id: dean.id)
l12 = Like.create!(flip_id: f3.id, user_id: lam.id)

l13 = Like.create!(flip_id: f5.id, user_id: lovelace.id)
l14 = Like.create!(flip_id: f5.id, user_id: hopper.id)
l15 = Like.create!(flip_id: f5.id, user_id: turing.id)

l15 = Like.create!(flip_id: f6.id, user_id: landin.id)
l16 = Like.create!(flip_id: f6.id, user_id: stallman.id)
l17 = Like.create!(flip_id: f6.id, user_id: dean.id)
l18 = Like.create!(flip_id: f6.id, user_id: lam.id)

l19 = Like.create!(flip_id: f9.id, user_id: horton.id)
l20 = Like.create!(flip_id: f9.id, user_id: dean.id)
l21 = Like.create!(flip_id: f9.id, user_id: de_icaza.id)
