library(htmltools)

ingredients <- c("avocado", "bacon", "bread", "butter", "cheese", "egg", "potato", "tomato", "pasta", "mushroom")
recipe <- data.frame(
  item = c("BREADLESS BLT - BACON CUPS",
            rep("BACON AVOCADO FRIES",2),
            rep("BACON WRAPPED EGGS",2),
            rep("FRIED EGG AND AVOCADO TOAST",3),
            rep("EGGS ON TOAST",3),
            rep("SCORED POTATOES",2),
            rep("BREAKFAST POTATOES", 5),
            rep("AVOCADO TOMATO AND MOZZARELLA", 4),
            rep("CROCKPOT MUSHROOMS", 2),
            rep("REAL SPAGHETTI CARBONARA", 4),
            rep("VEGGIE PASTA SALAD", 2),
            rep("AMAZING TOMATO BASIL PASTA", 3)
            
            ),
  
  cook_time = c("30min",
                 rep("20min",2),
                 rep("20min",2),
                 rep("10min",3),
                 rep("3min",3),
                 rep("50min",2),
                 rep("30min", 5),
                 rep("10min", 4),
                 rep("300min", 2),
                 rep("25min", 4),
                 rep("20min", 2),
                 rep("15min", 3)
                 
                 ),
  
  ingredient = c("bacon",
                  c("bacon", "avocado"),
                  c("bacon", "egg"),
                  c("egg", "bread", "avocado"),
                  c("egg", "bread", "butter"),
                  c("potato", "butter"),
                  c("potato", "butter", "egg", "bacon", "cheese"),
                  c("bread", "avocado", "tomato", "cheese"),
                  c("mushroom", "butter"),
                  c("pasta", "egg", "bacon", "cheese"),
                  c("pasta", "tomato"),
                  c("pasta", "tomato", "cheese")
                  
                  ),
  
  preparation = c("5-7 strips of BACON",
                   rep("20 strips of precooked packaged bacon (You can cook your own bacon, just cook it about 80% done)<br>1 large avocado, sliced into thin fry-size pieces(I sliced each avocado half into 5 slices, and then cut them down the middle to make them shorter, making 10 fries per half avocado)<br>Cayenne Pepper (optional)",2),
                   rep("2 slices bacon<br>2 fresh eggs<br>1/12 teaspoon salt<br>1/12 teaspoon pepper",2),
                   rep("2 eggs<br>2 slices bread, toasted<br>1/2 avocado<br>Salt, pepper and parsley for toppings<br>1 teaspoon lime juice<br>Non stick spray", 3),
                   rep("1/2 tablespoon butter<br>1 slice white bread<br>1 egg",3),
                   rep("4 Large Baking Potatoes<br>2 Tablespoons Butter, Melted, Divided<br>1/8 Teaspoon Paprika<br>1 Tablespoon Minced Parsley<br>Salt and Pepper to taste", 2),
                   rep("1 large baked potato (russett or sweet)<br>1 Tbsp. butter<br>2 eggs<br>2 strips bacon, cooked and diced<br>2 Tbsp. shredded cheese<br>1 Tbsp. fresh parsley, chopped<br>salt and freshly ground black pepper", 5),
                   rep("English muffins (or bread of your choice)<br>ripe avocado<brtomato (sliced)<brfresh mozzarella", 4),
                   rep("6 packages baby bella mushrooms - sliced if you like<br>1 packet dry hidden valley ranch<br>2 sticks butter<br>Chives and Chicken Broth (optional)", 2),
                   rep("spaghetti<br>bacon<br>eggs<br>black pepper<br>parmesan cheese", 4),
                   rep("1 pkg Veggie Pasta noodles(or more)<br>16oz Wish Bone Italian Dressing<br>2 fresh Tomato<br>1 or 2 heads fresh Broccoli<br>1 small Green Bell pepper <br>1 small Red Bell pepper <br>1 small Onion<br>1 can Black olives<br>1 fresh cucumber ", 2),
                   rep("12 ounces pasta (I used Linguine)<br>1 can (15 ounces) diced tomatoes with liquid (You can use fresh if you like as well)<br>1 large sweet onion, cut in julienne strips<br>4 cloves garlic, thinly sliced<br>1/2 teaspoon red pepper flakes<br>2 teaspoons dried oregano leaves<br>2 large sprigs basil, chopped<br>4 1/2 cups vegetable broth (regular broth and NOT low sodium)<br>2 tablespoons extra virgin olive oil<br>Parmesan cheese for garnish", 3)
                   
                   ),
  
  
  content = c("<ol><li>Place foil on the underside of a Muffin Pan - size varies on how big you want your cups (make sure the pan has a rim to catch the drippings)</li>
               <li>Form bacon into cups around the muffin pan</li>
               <li>Set oven to 400 degrees - then watch carefully, cooking time varies depending on how crispy you want your bacon, (10-15 minutes)</li>
               <li>fill with WHATEVER YOU WANT!!!!</li>",
               
               rep("<ol><li>Preheat oven to 425F.</li>
               <li>Take one strip of precooked bacon and try to gently stretch a little longer without it breaking (especially near the lighter pink and white parts).</li>
               <li>Carefully wrap around avocado fry, starting at one end and working to other end, and securely tuck in end piece.</li>
               <li>Repeat with remaining and place onto baking sheet.</li>
               <li>Sprinkle with Cayenne Pepper if desired</li>
               <li>Bake for 5-10 minutes or until bacon becomes crisp.</li>
               <li>Serve!",2),
               
               rep("<ol><li>Preheat oven 375 degrees.</li>
               <li>In medium frying pan fry bacon to soft transparent stage.</li>
               <li>Drain on paper towels.</li>
               <li>Line each slice around the side of each muffin cup. Ends may overlap.</li>
               <li>Break egg directly in the center of each muffin cup. 12 cup muffin pan.</li>
               <li>Slightly salt and pepper.</li>
               <li>Cook 15 to 20 minutes.</li>
               <li>Watch for whites and yolks to begin to set.</li>
               <li>Take out with small spatula on a serving plate.</li>
               <li>Serve with fork and knife.</li>
               <li>If you want the tops to be basted,after ten minutes of cooking, baste each egg once with 1/2 teaspoon of water.</li>
               <li>You can fry bacon the night before and drain and refrigerate for morning.</li>",2),
               
               rep("<ol><li>Toast bread</li>
               <li>Fry eggs in a small skillet over med-high heat with a little non-stick spray (or coconut oil works too!) then top with salt and pepper for taste</li>
               <li>Peel avocado and smash it up with the lime juice, salt and pepper</li>
               <li>When toast is done, spread avocado evenly on both slices</li>
               <li>Top it with the fried eggs and add additional toppings if you so desire</li>",3),
               
               rep("<ol><li>Butter both sides of bread. Cut a circular hole in the center of the slice of bread, about 2 1/2 inches in diameter.</li>
               <li>Heat a frying pan or griddle on medium-high heat. When the frying pan is hot, place the bread into the pan and let it brown for one minute. Flip the toast over and let the other side brown for one minute.</li>
               <li>Break the egg into the hole in the bread. Cook for 2 minutes, or until the egg is cooked to the consistency you prefer.</li>",3),
               
               rep("<ol><li>With a sharp knife, cut potatoes in half lengthwise. Slice each half widthwise six times, but not all the way through; fan potatoes slightly.</li>
               <li>Place in a shallow baking dish. Brush potatoes with 1 tablespoon butter. Sprinkle with paprika, parsley, salt and pepper. Bake, uncovered, at 350° for 50 minutes or until tender. Drizzle with remaining butter.</li>", 2),
               
               rep("<ol><li>Lay the baked potato on its side, and use a knife to carefully cut off the top third of the potato. With a spoon, hollow out the middle of the potato to make a “bowl, leaving the potato as thick or thin as would like. (Just remember, the more room you leave, the more room for eggs, bacon and cheese!)</li>
               <li>Place 1/2 tablespoon of butter in the middle of each bowl. Then gently break an egg into each bowl, careful not to break the yolk. Top with bacon, cheese, parsley, and then season with salt and pepper.</li>
               <li>Bake at 350 degrees F for 20-25 minutes, or until the egg whites are set. Serve immediately.</li>", 5),
               
               rep("<ol><li>Heat up a Pan (or Panini Press if you have one - if you don't... win one HERE)</li>
               <li>Stack the ingredients on top of the muffin.  Cheese, Tomato, Avocado, Cheese</li>
               <li>Season with Salt and Pepper</li>
               <li>Then grill like a grilled cheese until melted</li>", 4),
               
               rep("<ol><li>Mix everything together in a crock pot... cook on low for about 5 hours or until tender :)</li>", 2),
               
               rep("Begin by setting your pasta to boil for the time recommended by the package (be sure to salt the water). note: this recipe feeds one person, for multiple servings, increase the amount of pasta and use more eggs ex: two whole eggs for two people, two and one yolk for three and so on.
               <ol><li>Break one whole egg and one yolk into a bowl and lightly mix</li>
               <li>Add 1 1/2 tbsp of parmesan cheese and mix until combined</li>
               <li>Add a copious amount of black pepper (at least 3 tsp), mix, and set aside</li>
               <li>Cut your bacon into small bite sizes pieces or cubes and set it in a frying pan. fry until crispy, don't worry about the excess oil, it adds to the flavor of the pasta! If you finish frying your bacon before the spaghetti is done cooking reduce the heat in your frying pan to minimum in the mean time.</li>
               <li>When your pasta is cooked to your liking, ladle a little of the pasta water into the frying pan with the bacon.</li>
               <li>Now for the hard part...you must work quickly here or your carbonara will turn into scrambled eggs! Strain the pasta and remove the frying pan from heat. Add the spaghetti to the frying pan and toss with tongs to mix in the bacon. now grab your bowl with your egg mixture and steadily pour it in the center of your pasta and bacon while stirring with forks or tongs. Be sure to coat the pasta evenly with the egg mixture and stir quickly so the egg do not overheat.</li>
               <li>Now you're done! serve immediately on a plate and sprinkle more black pepper and parmesan cheese to your liking, enjoy!</li>", 4),
               
               rep("<ol><li>Cook pasta until just about done. Don't cook pasta to long, it will get mushy.</li>
               <li>Drain pasta and cool off under cold water.</li>
               <li>Wash veggies and cut into small bites.</li>
               <li>Slice olives. (you could buy the olives that are all ready sliced)</li>
               <li>Mix pasta and veggies.</li>
               <li>Add dressing to taste. I like a lot of it.</li>
               <li>Refrigerate until chilled.</li>", 2),
               
               rep("<ol><li>Place pasta, tomatoes, onion, garlic, basil, in a large stock pot. Pour in vegetable broth. Sprinkle on top the pepper flakes and oregano. Drizzle top with oil.</li>
               <li>Cover pot and bring to a boil. Reduce to a low simmer and keep covered and cook for about 10 minutes, stirring every 2 minutes or so. Cook until almost all liquid has evaporated – I left about an inch of liquid in the bottom of the pot – but you can reduce as desired .</li>
               <li>Season to taste with salt and pepper , stirring pasta several times to distribute the liquid in the bottom of the pot. Serve garnished with Parmesan cheese.</li>", 3)
               
               ),
  
  image = c("baconcups.jpg",
             rep("baconavocadofries.jpg",2),
             rep("baconwrappedeggs.jpg",2),
             rep("friedeggavocado.jpg",3),
             rep("eggsontoast.jpg",3),
             rep("scoredpotatoescollage.jpg",2),
             rep("breakfastpotatoes.jpg", 5),
             rep("capresegrilledcheese.jpg", 4),
             rep("CROCKPOTMUSHROOMS.jpg", 2),
             rep("baconcarbonara.jpg", 4),
             rep("pastasalad.jpg", 2),
             rep("tomatobasilpasta.jpg", 3)
             
             )
)

save(recipe, file="recipe.rda")

