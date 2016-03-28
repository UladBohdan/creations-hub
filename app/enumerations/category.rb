class Category < EnumerateIt::Base
  associate_values(
      fiction:  [1, "Fiction"],
      fantasy:  [2, "Fantasy"],
      comedy:  [3, "Comedy"]
  )
end