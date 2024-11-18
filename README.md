# recipes-project

# Steps to run

App will run on iOS 16.6 and up.  Variables containing the different endpoints are in “DefaultURLService.swift”.  Assign these to “urlComponents.path” on line 18 to see how the app reacts to each one.

# Focus Areas

My favorite part of app creation is working with UI/UX elements, so I tend to focus in on those the most. I believe it could be argued that the UI of an app is its most important component. After all, the goal of almost all apps is to have users interact with it. I try to find ways to keep the app interesting and engaging to use while also retaining its simplicity.  For this app, I put the images at the forefront. People like looking at pictures (and if they’re anything like me, especially pictures of food), so I thought they should be the focus of the app. To keep the app clean and minimalistic, I only included a title for each recipe until it is tapped. Once tapped, the title expands to an overlay giving some additional information. This is where the cuisine type and relevant links are presented. For visual interest, I added country map icons corresponding to the cuisine. I also added a search bar and the ability to filter by cuisine. 

I also don’t want to understate the importance of an app’s architecture. Apps are constantly evolving, and the architecture is an integral part of that evolution. Writing clean, testable, and readable code is essential for maintainability. While this was a simple app built by a team of one, I still wrote the code with the mindset that it might need to be changed by somebody else in the future.

# Time Spent

I tend to get lost in the details when creating anything. I could spend hours making almost imperceptible adjustments, so time management for me comes down to making sure I’m moving forward and making meaningful changes. I like to split a project into tasks and sub-tasks. I only stay on a certain task until I get whatever it is working. It might not be good yet, but once it’s working, I move to the next task. Once I go through all or most of the tasks, I’ll go back through to see what’s good and what needs to be improved. This keeps me from getting stuck and most importantly, it keeps my mind fresh. Many times, my best ideas for something come when I’m working on something completely different. 

That being said, unless there’s a hard deadline, I feel it’s important to take the time to do things right even if it means taking more time than initially planned. I don’t want to, but I think this paragraph demands a “Rome wasn’t built in a day”. Especially with something like architecture, extra time spent now could save many hours down the road when a different person is having to understand and work through code that they didn’t write. This project took me about 20 hours to complete, which is more than I’d hoped, but I think the extra time was well utilized.

# Trade-Offs and Decisions

Knowing I get lost in the details of UI, that’s usually where I start making trade-offs if I need to. When it’s crunch time, I’ve probably already spent enough time on UI/UX, so I focus on making sure everything else is as good as it can be. For this app, I would have liked to add more sorting and grouping features, but ultimately, I felt they weren’t completely necessary, so I decided to use my time elsewhere. I also would’ve liked to have a more dynamic recipe card but decided that was a detail that could wait for another time.

# Weakest link

While I do my best to have a good architecture, I think that’s a skill that comes with experience and is best learned as part of team. Seeing good code or even having to work on bad code are essential learning experiences. Since I’m new to the field and lack experience, this is probably the area where I have the most to learn.

# Dependencies

I used SDWebImage to handle the loading and caching of the images.
