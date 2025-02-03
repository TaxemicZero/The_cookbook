import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(const MyApp());

/// main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'The Cookbook';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),
          shape: Border(
              bottom: BorderSide(
                  color: Colors.black,
                  width: 4
              )
          ),
          elevation: 4,),
        body: DishWidget(),
      ),
    );
  }
}

/// stateful widget that the main application instantiates
class DishWidget extends StatefulWidget {
  const DishWidget({Key? key}) : super(key: key);

  @override
  State<DishWidget> createState() => _DishWidgetState();
}

enum Recipe { borsch, cutlet, blini }

var pictures = const <Recipe, String>{
  Recipe.borsch: 'assets/borsch.png',
  Recipe.cutlet: 'assets/cutlet.png',
  Recipe.blini: 'assets/blini.png'
};

var cooking_steps_reference = <Recipe, String>{
  Recipe.borsch: 'assets/borsch_recipe.txt',
  Recipe.cutlet: 'assets/cutlet_recipe.txt',
  Recipe.blini: 'assets/blini_recipe.txt'
};

/// private State class that goes with DishWidget
class _DishWidgetState extends State<DishWidget> {
  Recipe? _recipe = Recipe.borsch;
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: SingleChildScrollView(
          child:
            Column(
            children: <Widget>[
              Container(
                color: Color.fromRGBO(139, 0, 0, 1),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Image>[
                      Image.asset(pictures[_recipe]!,
                        height: 200,
                        width: 300,
                      ),
                    ]

                ),
              ),

              Divider(
                thickness: 4,
                height: 4,
                color: Colors.black,
              ),
              Container(
                height: 80,
                color: Colors.white,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                          children: [
                            const Text('Borscht'),
                            Radio<Recipe>(
                              value: Recipe.borsch,
                              groupValue: _recipe,
                              onChanged: (Recipe? value) {
                                setState(() {
                                  _recipe = value;
                                });
                              },
                            ),
                          ]),
                    VerticalDivider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        const Text('Kiev cutlets'),
                        Radio<Recipe>(
                          value: Recipe.cutlet,
                          groupValue: _recipe,
                          onChanged: (Recipe? value) {
                            setState(() {
                              _recipe = value;
                            });
                          },
                        ),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        const Text('Blini'),
                        Radio<Recipe>(
                          value: Recipe.blini,
                          groupValue: _recipe,
                          onChanged: (Recipe? value) {
                            setState(() {
                              _recipe = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ]
                ),

              ),
              Divider(
                thickness: 4,
                height: 4,
                color: Colors.grey,
              ),

              /* I never figured the correct relative path, so yeah
              Would be cool if that actually worked, it didn't give any errors

              FutureBuilder(future: File(cooking_steps_reference[_recipe]!).readAsString(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(snapshot.data ?? "No data");
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
              ),
              */
              IntrinsicHeight(
                child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffeedac9), Color(0xfff6b23c)],
                          stops: [0.01, 0.99],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          )
                      ),
                    ),

                    Flexible(child:
                      Container(
                        color: Color.fromRGBO(238,218,201, 10),
                        child: Text(
                          cooking_steps[_recipe]!,
                          softWrap: true,
                        ),
                      )

                    ),
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffeedac9), Color(0xfff6b23c)],
                            stops: [0.01, 0.99],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      );
  }
}

//This is straight-up unholy, surely I am not supposed to do it like this

var cooking_steps = <Recipe, String>{
  Recipe.borsch: """Classic Borscht Recipe

  Ingredients:

  2 medium beets, peeled and grated
  1 large potato, peeled and diced
  1 large carrot, peeled and grated
  1 medium onion, finely chopped
  2 cloves garlic, minced
  1/2 head of cabbage, thinly sliced
  1 bell pepper, diced
  2 tomatoes, chopped (or 2 tablespoons tomato paste)
  1 bay leaf
  1 tablespoon vinegar or lemon juice (for acidity)
  1 teaspoon sugar
  Salt and pepper to taste
  6 cups beef or vegetable broth
  2 tablespoons vegetable oil
  Fresh dill or parsley, chopped (for garnish)
Sour cream (for serving)

Instructions:

1.    In a large pot, heat the vegetable oil over medium heat. Add the onions and garlic, sauté until translucent.

2.    Add the grated beets and carrots. Cook for about 5 minutes, stirring occasionally.

3.    Stir in the tomatoes or tomato paste. Cook for another 5 minutes.

4.    Pour in the broth, then add the diced potatoes, cabbage, bell pepper, bay leaf, vinegar (or lemon juice), and sugar. Season with salt and pepper.

5.    Bring to a boil, then reduce the heat and let it simmer for about 30-40 minutes, or until the vegetables are tender.

6.    Adjust seasoning if needed. Remove from heat and let it sit for about 10 minutes to develop flavors.

7.    Serve hot, garnished with fresh dill or parsley and a dollop of sour cream.""",
  Recipe.cutlet: """
  Kiev cutlets Recipe

Ingredients:

    2 large chicken breasts
    4 tablespoons unsalted butter, softened
    2 cloves garlic, minced
    2 tablespoons fresh parsley, chopped
    1 teaspoon lemon juice
    Salt and black pepper, to taste
    1 cup all-purpose flour
    2 eggs, beaten
    1 cup breadcrumbs (panko or regular)
    1/2 teaspoon paprika (optional)
    Vegetable oil (for frying)

Instructions:

1.    Prepare the garlic butter: In a small bowl, mix the softened butter with garlic, parsley, lemon juice, salt, and pepper. Shape the butter into a small log, wrap in plastic wrap, and freeze for at least 30 minutes.

2.    Prepare the chicken: Butterfly each chicken breast by slicing it in half horizontally, but not all the way through. Open it like a book and pound it gently to an even thickness, about 1/4 inch (5-6 mm).

3.    Wrap the butter: Place a piece of the frozen garlic butter in the center of each chicken breast. Fold the sides over and roll tightly, sealing the butter inside. Secure with toothpicks if necessary.

4.    Coat the chicken: Dredge each chicken roll in flour, then dip into the beaten eggs, and finally coat it in breadcrumbs. Repeat the egg and breadcrumb coating for a crispier crust.

5.    Chill: Place the coated chicken rolls in the fridge for at least 30 minutes to help them hold their shape.

6.    Fry the chicken: Heat vegetable oil in a deep pan over medium heat. Fry the chicken rolls for about 4-5 minutes per side, until golden brown.

7.    Bake (optional but recommended): Transfer the fried chicken to a preheated oven at 180°C (350°F) and bake for 10-15 minutes to ensure the inside is fully cooked.

8.    Serve: Let the chicken rest for a few minutes before slicing. Serve hot with mashed potatoes or a fresh salad.
  """,
  Recipe.blini: """Thin Crepes (Blini) Recipe

Ingredients:

    2 cups (480 ml) milk
    1 cup (125 g) all-purpose flour
    2 large eggs
    1 tablespoon sugar (optional, for sweet crepes)
    1/4 teaspoon salt
    2 tablespoons vegetable oil or melted butter
    1/2 teaspoon vanilla extract (optional, for sweet crepes)
    Butter or oil for frying

Instructions:

1.    Make the batter: In a mixing bowl, whisk the eggs, milk, sugar (if using), salt, and vanilla extract. Gradually add the flour while whisking until smooth. Stir in the melted butter or vegetable oil.

2.    Rest the batter: Let the batter sit for 15-30 minutes to allow the flour to absorb the liquid. If it's too thick, add a little more milk to achieve a thin, runny consistency.

3.    Heat the pan: Heat a non-stick frying pan or crepe pan over medium heat. Lightly grease with butter or oil.

4.    Cook the crepes: Pour a small amount of batter (about 1/4 cup) into the pan, swirling it around quickly to coat the bottom. Cook for about 1-2 minutes until the edges lift slightly and the bottom is golden. Flip and cook for another 30-60 seconds.

5.    Repeat: Continue cooking, greasing the pan as needed, until all the batter is used. Stack the crepes on a plate, covering them with a clean towel to keep them warm.

6.    Serve: Enjoy with jam, honey, sour cream, or any filling of your choice.
  """
};