class Category < EnumerateIt::Base
  associate_values(
      fiction:  [1, "Fiction"],
      fantasy:  [2, "Fantasy"],
      comedy:  [3, "Comedy"],
      science: [4, "Science"],
      cooking: [5, "Cooking"],
      programming: [6, "Programming"],
      others: [7, "Others"]
  )

end