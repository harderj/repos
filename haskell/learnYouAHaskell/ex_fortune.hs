
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  putStrLn ("Read this carefully, because this is your future: " ++ tellFortune name)

tellFortune name = "Some day you'll die, but before that you will most definitely eat a large pepperoni pizza."