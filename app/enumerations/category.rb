class Category < EnumerateIt::Base
  associate_values(
      category1:  [1, "Fiction"],
      category2:  [2, "Fantasy"],
      category3:  [3, "Comedy"]
  )
end