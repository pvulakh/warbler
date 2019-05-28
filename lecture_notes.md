# Heroku
 - one of the first cloud platforms, allows folks to host their apps on the cloud
 - used to be only for rails, part of why rails became so popular (heroku made it easy to push to production)
 - heroku's expanded beyond rails, now supports other frameworks that work with java, node, python, golang, etc

## Highlevel overview: 

We'll add heroku as a git remote repository for Warble and push all our code up.

What does our repo look like right now? 
- we gitignore node_modules, bundle.js so our repo won't have that 
- we also don't have data or gems in the repo 
- So just like when we clone a repo/download a skeleton onto a new computer and we do some setup
 (bundle install for gems and npm install for node modules), 
  we'll need to do the same type of setup for heroku

## Prepare Warbler :) 

quick note: As you know from looking at our lecture notes repository, warbler itself was not a git repo because we never want nested repositories! In order to push to heroku, 
we've copied warbler into a seperate directory outside of lecture notes and initialized
a git repo within this new warbler directory. This is what we're working with today. 

Now we'll go through the steps that you will be going through with your own apps later today. 

1) remove all debuggers from warbler (cmd+shift+f)
2) gitignore: make sure ignoring node_modules, bundle.js
3) package.json - add engines (our npm and node versions) and scripts
  ```
  {
  "engines": { // top-level key
    "node": "8.4.0", // run node -v to get version 
    "npm": "6.1.0" // run npm -v to get version
  },
  "scripts": { // top-level key
    "postinstall": "webpack" // takes care of webacking after we npm install
  }
}
```
4) `bundle install`
5) `npm install` 
6) `git status`, `git add .`, `git status`
7) `git commit -m 'Prepare for initial heroku push'`
8) `git push origin master`

## Heroku time! 

In order to push to heroku, you'll need to create a heroku account and download the heroku
command line interface. Oliver already has an account and the heroku cli installed so we won't go through that process right now. 

There's a reading on aaonline walking you through this process and 
we'll all push to heroku together after this, so you'll have all of us to help you with that if you run into any snags. 

1) go to heroku.com and login
2) new --> create new app (warbler-2 if avail)
3) settings --> add buildpacks: these run in the order specified
4) heroku/nodejs 
5) heroku/ruby 
 * ORDER IMPORTANT! If heroku/ruby ran first, it would recompile our assets before creating a new bundle.js. 
  We want bundle.js to be up-to-date before Rails recompiles our assets.
6) back to terminal: log into heroku by running `heroku login` 
7) `heroku git:remote -a warbler-2`
8) `git push heroku master`
  * different from git push origin master! 
  you will always have to first push to master (or whatever feature branch you're working on), 
  and THEN push to heroku afterwards
  while this is happening - any questions?
9 ) `heroku logs` (or `heroku logs -t`)
  * useful command, shows server logs for our app in production 
9) `heroku run bundle exec rails db:migrate`
10) `heroku run bundle exec rails db:seed`
11) go look at it!

## Static Images

Old way: put images into the `./public` folder in our app (this is where our 404 page goes, etc)

Problem: You're working on your fullstack, you've saved an image for your splash with the title of 
`best-cat-ever.png` into `./public`. A few days later, you find a MUCH BETTER cat image and you want to change your splash. You call this image `best-cat-ever.png` as well, and replace it
in your `./public` folder. You go to look at your site but...the old image is still there!
That's because the browser cached it since the filename was the same. 

Solution: use the built-in Rails assets pipeline. The assets pipeline in rails uses fingerprinting, which is a type of algorithm that makes the file name dependent on the file contents (just like how two people might share the same name, but still have different fingerprints). Now, if you swapped out 1 image for another but kept the filename the same, the browser will know not to use the cached version because the fingerprint has changed. 

Procedure: go to `./app/assets`, save photo in your images folder, and whenever you want to reference this image's path, use the built-in rails helper `image_url` (or `asset_url`). If you want an HTML image tag, you can also use the built in `image_tag` helper method. 

Takeaway: don't put images in `./public`! Make use of the assets pipeline. 

How to access assets in diff parts of your app? 
- In rails views: `image_url` and `asset_url` generate fingerprinted filenames
- We have one image in Warbler right now in assests/images
- go to application.html.erb
- line 14: warbler app uses `image_tag` to render our warbler image in application.html.erb
- inspect in console
- returns an `img` tag with the `src` property set to a fingerprinted filename
- To use these files in the frontend: bootstrap to your window! Let's do that. 
1) in application.html.erb, let's remove our `image_tag` on line 17. 
2) on line 10, 
  ``` 
    <script type="text/javascript">
      window.warblerURL = "<%= image_url('warbler.png')%>"
    </script>
  ```
Now in our components, we have reference to this image through `window.warblerURL`
Let's go to our app component and use this! 
4) app.jsx line 14:
    `<img className="img-warbler" src={window.warblerURL} />`
5) git add ., git commit, git push origin master, git push heroku master
6) check it out!
 
 Bootstrapping images on the window will be useful if you want to include a logo on your page. 
 Avoid having more than a few images in our assets folder - this slows our apps down. Chances are we'll be using AWS for images in our fullstacks anyway, so there's not really a need for this. 

## Troubleshooting

Heroku is pickier than webpack and may reject your initial push if something's broken that webpack didn't pick up.
- make sure git is up to date (run git status)
- look at your stack before the push rejected message 
- can run `heroku logs` as well (shows server logs for our app in production)

Remember that we DO push to heroku all together after this, so first look at the stack trace and try to solve on your own, but we are here to help you. 

Useful commands for debugging after initial push:
- `heroku logs` shows server logs for our app in production 
- `heroku run be rails console` - lets you interact w prod database
- you can run any rails command by appending `heroku run` in front of it 


## Top Ten FullStack Bugs

We'll slack and email this out - should be your first stop on bugs you can't catch right away! 

https://github.com/appacademy/2019-04-08-NYC-Lecture-Notes/blob/master/w8d2/top_ten_fullstack_bugs.md



