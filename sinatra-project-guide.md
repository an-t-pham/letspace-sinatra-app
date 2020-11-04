##Checklist

### PART 1 - Project Setup: Corneal, MVC, ActiveRecord

**BEFORE YOU CODE**
- [x] 1. Check project requirements in spec.md
- [x] 2. Ideate! What do you want to build?
     - choose a domain you're familiar with!
     - choose a domain you care about
- [x] 3. Wireframing & User Stories
     - Write down your models, their attributes, and their associations
     - "As a user, I can ... "
     - "A user should be able to ... "
     - What does your app do?
- [x] 4. Design your MVP = 'Minimum Viable Product' vs. what are my 'stretch goals'
     - Stretch goals - bonus features you want but don't need

**NOW WE CODE (BUT JUST OUR MODELS - NO CONTROLLERS OR VIEWS)**

- [x] 5. Generate new project using corneal gem
- [x] 6. Create github repo
- [x] 7. Build your models
     - Migrations
     - Model classes
     - Associations
- [x] 8. Test your models and associations in the console
     - Create some seed data
     - Tested our associations in 'tux'
     - Adjust migrations as needed

**KEYWORDS FOR ASSESSMENT**
- ActiveRecord
- MVC
- Assosciations (has_many, belongs_to, has_many: :through)


### PART 2

**NOW, CONSIDER CONTROLLERS, APPLICATION CONTROLLER, AND VIEWS**

*IMPORTANT:* Build views and controller actions based on the flow of your app, one step at a time, testing as you go!

- Use 'shotgun' and 'pry' (or 'raise'/'inspect') all the time!

**START WITH LOGIN**

- [x] 9. Create your 'UsersController'
   - Mount new controller in 'config.ru' with 'use LandlordsController' (why do we add this?) 

- [x] 10. Enable 'session' in 'ApplicationController'
   - Enable sessions
   - Create session secret



- [x] 11. Build routes and views for login
    - Build your 'get' login route + "login" view
    - Build your 'post' login route
         -**Tip**: Here is where authenticate the user and leverage the session hash to log them in!
    - Build your 'get users/:id' route + "show" view

- [x] 12. Create your 'ApplicationController' helper methods
   - **Ask**: Why do we add this?
   - '#logged_in?': checks if the user is logged in
   - '#current_user' :keeps track of the user currently logged in

 Start with your ApplicationController helpers - '#logged_in?' and '#current_user'
add your login/signup/signout routes 

**MOVE ON TO SIGN UP**
- [x] 13. Build routes and views for signup
    - Build your 'get' signup route + "signup" view
    - Build your 'post' signup route

**WRAP UP WITH LOG OUT**
- [x] 14. Build your 'get' logout route

### PART 3 - CRUD: Create, Read, Update, Delete

- [x] 15. Create your 'PropertiesController'
   - Mount new controller in 'config.ru' with 'use PropertiesController'
 

- [] 16. Implement READ functionality
   - Create 'get' posts route
   - Create 'post' route to create new post

- [] 17. Implement CREATE functionality
   - Create 'get' posts route and view to render form
   - Create 'post' route to create new post

- [] 18. Implement UPDATE functionality
   - Add 'use Rack::MethodOverride' in 'config.ru'
   - ** Ask**: Why do we add this?
   - Create 'get' route and view to render form
   - Create 'patch' route to update an existing post

- [] 19. Implement DELETE functionality
   - Create 'delete' form in relevant view
   - Create 'delete' route to delete post


### PART 4 - Tighten Up!: Validations and Authorization

 - [] 20. Implement 'sinatra-flash' gem to display validation

   

