Music Recommender
=================

Recommends the best songs for you based on a **list** of songs you input.

###Instructions

It's easy to use!

Clone the repository

    git clone https://github.com/cschubiner/music-recommender.git
cd into the directory

    cd music-recommender

Put all of your songs into a text file titled *musicList.txt* with the following format:
    
    TITLE *by* ARTIST

For example:

    Accidentally In Love *by* Counting Crows
    Adam's Song *by* Blink 182
    All In *by* Lifehouse

Install the required ruby gems:

    gem install rest-client
    gem install json

Then run the script:
    
    ruby musicRecommender.rb


###Sample output
    *** Top 40 Recommended Songs ***
    1. 3 AM by Matchbox Twenty	 Score: 22.0
    2. Meet Virginia by Train	 Score: 20.54
    3. Father Of Mine by Everclear	 Score: 20.5
    4. Desperately Wanting by Better Than Ezra	 Score: 20.46
    5. Hemorrhage (In My Hands) by Fuel	 Score: 19.13
    6. All I Want by Toad The Wet Sprocket	 Score: 18.45
    7. The World I Know by Collective Soul	 Score: 18.28
    8. Hold My Hand by Hootie & The Blowfish	 Score: 18.1
    9. The Way by Fastball	 Score: 17.94
    10. Runaway Train by Soul Asylum	 Score: 17.33
    11. Out Of My Head by Fastball	 Score: 17.29
    12. Little Miss Can't Be Wrong by Spin Doctors	 Score: 16.59
    13. Blurry by Puddle of Mudd	 Score: 16.3
    14. 6th Avenue Heartache by The Wallflowers	 Score: 16.14
    15. Walk On The Ocean by Toad The Wet Sprocket	 Score: 15.87
    16. Counting Blue Cars by Dishwalla	 Score: 15.68
    17. Scars by Papa Roach	 Score: 15.57
    18. Crash Into Me by Dave Matthews Band	 Score: 15.22
    19. All For You (Live) by Sister Hazel	 Score: 14.9
    20. Addicted by Saving Abel	 Score: 14.86
    21. Barely Breathing by Duncan Sheik	 Score: 14.52
    22. You Wanted More by Tonic	 Score: 14.36
    23. Cumbersome by Seven Mary Three	 Score: 14.25
    24. Fly by Sugar Ray	 Score: 14.12
    25. Sex and Candy by Marcy Playground	 Score: 13.98
    26. Clumsy by Our Lady Peace	 Score: 13.34
    27. Walkin' On The Sun by Smash Mouth	 Score: 13.33
    28. Hey Leonardo (She Likes Me for Me) by Blessid Union Of Souls	 Score: 12.88
    29. Apologize by OneRepublic	 Score: 12.82
    30. Wasting My Time by Default	 Score: 12.67
    31. Little Black Backpack by Stroke 9	 Score: 12.56
    32. Santa Monica by Everclear	 Score: 12.15
    33. Better Than Me by Hinder	 Score: 12.04
    34. Absolutely (Story Of A Girl) - Radio Mix by Nine Days	 Score: 11.86
    35. Love Drunk by Boys Like Girls	 Score: 11.85
    36. Out Of Control by Hoobastank	 Score: 11.67
    37. In the Meantime by Spacehog	 Score: 11.58
    38. Sweetness by Jimmy Eat World	 Score: 11.55
    39. Interstate Love Song by Stone Temple Pilots	 Score: 11.54
    40. All I Wanna Do by Sheryl Crow	 Score: 11.47
    
###Additional Notes
The score is gotten from the matching score Last.fm gives to each song. It is calculating by summing the scores of each matched song for every song you inputted together.
