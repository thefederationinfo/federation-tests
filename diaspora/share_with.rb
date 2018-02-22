user = User.find_by(username: ARGV[0])
person = Person.find_or_fetch_by_identifier(ARGV[1])
Aspect.find_each {|obj|
  if user.id == obj.user_id
    user.share_with(person, obj)
  end
}
