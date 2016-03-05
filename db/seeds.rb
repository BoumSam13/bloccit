require "random_data"

15.times do
    Topic.create!(
        name: RandomData.random_sentence,
        description: RandomData.random_paragraph
    )
end
topics = Topic.all

50.times do
    SponsoredPost.create!(
        topic: topics.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        price: 5
    )
end

50.times do
    Post.create!(
        topic: topics.sample,
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph
   )
 end
posts = Post.all
post1 = Post.first
 
100.times do
    Comment.create!(
        post: posts.sample,
        body: RandomData.random_paragraph
   )
end

50.times do
    Advertisement.create!(
        title: RandomData.random_sentence,
        copy: RandomData.random_paragraph,
        price: 1
    )
end

100.times do
    Question.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: false
    )
end
 
puts "#{Post.count}"
Post.find_or_create_by(title: "A title", body: "A body")
puts "#{Post.count}"

puts "#{Comment.count}"
Comment.find_or_create_by(body: "A comment body", post: post1)
puts "#{Comment.count}"

puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
