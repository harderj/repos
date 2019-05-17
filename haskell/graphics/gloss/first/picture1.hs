
import Graphics.Gloss

main :: IO ()
main = display display1 white Blank

anotherIO :: IO ()
anotherIO = putStrLn "Hey."

display1 = InWindow "Picture 1" (600, 600) (10, 10)

