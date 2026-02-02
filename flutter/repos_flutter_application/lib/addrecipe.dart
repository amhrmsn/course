import 'package:flutter/material.dart';
import 'class/recipe.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescController = TextEditingController();
  final TextEditingController _recipePhotoController = TextEditingController();
  String _recipeCategory = "Indonesian";       
  int _charleft = 0;

  @override
  void initState() {
    super.initState();
    _recipeNameController.text = "Food name ...";
    _recipeDescController.text = "Recipe of ...";
    _charleft = 200 - _recipeDescController.text.length;
  }

  Color getButtonColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Recepi")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _recipeNameController,
              onChanged: (value) {
                print(_recipeNameController.text);
                print(value);
              },
            ),
            TextField(
              controller:  _recipeDescController,
              onChanged: (value) {
                setState(() {
                  _charleft = 200 - value.length; 
                });
              },
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: null,
            ),
            Text("char left: $_charleft"),
            TextField(
              controller: _recipePhotoController,
              onSubmitted: (v) {
                setState(() {});
              },
            ),
            Image.network(_recipePhotoController.text),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: "Indonesian",
                    child: Text("Indonesian"),
                  ),
                  DropdownMenuItem(
                    value: "Japanese",
                    child: Text("Japanese"),
                  ),
                  DropdownMenuItem(
                    value: "Korean",
                    child: Text("Korean"),
                  ),
                ],
                value: _recipeCategory,
                onChanged: (value) {
                  setState(() {
                    _recipeCategory = value!;
                  });
                },
                ),        
            ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll(5),
                backgroundColor:
                   WidgetStateProperty.resolveWith(getButtonColor),
              ),
              onPressed: () {
                recipes.add(Recipe(
                    id: recipes.length + 1,
                    name: _recipeNameController.text,
                    desc: _recipeDescController.text,
                    photo: _recipePhotoController.text,
                  ));
                showDialog(
                  context: context, 
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Add Recipe'),
                     content: Text('Recipe successfully added'),
                     actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
                     ],
                  ),
                );
              }, 
              child: const Text("SUBMIT")
            )
          ],
        ),
      )
    );
  }
}