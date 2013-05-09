class GroupUsers
  constructor: (id)->
   @id: id

class User extends GroupUsers
  constructor: (name, group)->
    @name: name
    @group: group

class TypeAchievements

class Achievement extends TypeAchievements
  constructor: (name, time, pries,)->
    @name: name
    @time: time
    @pries: pries


