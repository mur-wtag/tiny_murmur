# TinyMurmur
Micro-blog built for portfolio 

### How to run:
1. `bundle`
2. `yarn`
3. `rails db:create db:migrate`
4. `bin/rails tailwindcss:watch`
5. `bin/rails server`

### What inside it
- **In this app we are call post as Murmur**
- User can sign up for create post and follow other users
- User can follow other users.
- User can visit other or own profile but clicking on the name of the user
- By following, a list of posts posted by other users is displayed in the timeline.
- The user can post as many times as he wants.
- Only the post author can delete or modify it.
- The user can add LIKE to another person's posts.
- User can comment on post too
- Real-time updates using Turbo + Stimulus 
- Fully responsive UI with TailwindCSS + DaisyUI

### Tech Stack
- **Backend**: Ruby 3.3, Rails 8.0.2 
- **Database**: PostgreSQL 
- **Frontend**: Turbo, Stimulus, TailwindCSS, DaisyUI 
- **Authentication**: Clearance 
- **Authorization**: Pundit 
- **Testing**: RSpec, FactoryBot, Shoulda Matchers, Capybara, Selenium
- **Caching / Queue / Real-time**: solid_cache, solid_queue, solid_cable
